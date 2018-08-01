module UsersHelper
  def reviewed_by(reviews,job)
    html = ""
    review = reviews.find_by(job_id: job.id, user_id: current_user)
    html = review.present? ? "<b>Yes</b> on <b>Date: #{review.created_at.strftime('%d/%m/%Y %-I:%M%p')}</b>" : "<b>No</b>"
    return html.html_safe
  end
  def interviewed_by(job)
    html = ""
    if job.interview.present? && !job.interview.interview_schedules.where(user_id: current_user).empty?
      interview_dates = job.interview.interview_schedules.where(user_id: current_user).map(&:interview_avail_dates).flatten
      # interview_dates = interview_dates.collect{|k| k.values}.flatten.join(', ')
      html =  "<b>Yes</b><br> on"
      interview_dates.each do |interview|
        html += "<b> #{interview.values.join(', ')} </b><br>"
      end
    else
      html = "<b>No</b>"
    end
    return html.html_safe
  end

  def interview_status(job)
    if job.interview.present?
      html = ""
      stages = job.interview.interview_schedules.where(user_id: current_user).map(&:stage).flatten
      stages.each do |stage|
        html += "<b> pre screen </b> round<br>"# if stage.one?
        html += "<b>"+stage.try(:ordinalize)+"</b> round<br>"# unless stage.zero?
      end
      # html += link_to "view schedule","/interview_schedules/#{job.id}"
      html += link_to "view schedule",interview_schedule_path(job)
      return html.html_safe
    end
  end

  def cv_download(reviews,job)
    html = ""
    review = reviews.find_by(job_id: job.id, user_id: current_user,is_cv_download: true)
    html = review.present? ? "<b>Yes</b> on <b>Date: #{review.cv_download_date.strftime('%d/%m/%Y %-I:%M%p')}</b>" : "CV awaiting download"
    return html.html_safe
  end


  def reviewed_client_section(job)
    html = ""
    reviews = Review.where(job_id: job.id)
    reviews.each do |review|
      html +=	"<div style='padding:22px;'>#{review.user.first_name} (#{review.user.email}) <br>"
      unless review.is_cv_download
        html += "CV awaiting download"
      else
        resumes = review.user.resumes.where(id: review.cv_ids)
        resumes.each do |res|
          html += link_to "#{res.cv_file_name}", resume_path(res)
          # html += link_to "#{res.cv_file_name}", "/resumes/#{res.id}/download?job_id=#{job.id}"

        end
      end
      html += "</div>"
    end
    html.html_safe
  end

  def cv_download_client_section(job)
    html = ""
    # reviews = Review.where(job_id: job.id)
    # reviews.each do |review|
    #  	unless review.is_cv_download
    # 		html += "<div style='border-bottom:1px solid #ccc;padding:22px;'>CV awaiting download</div>"
    #   	else
    #    	resumes = review.user.resumes.where(id: review.cv_ids)
    #    	resumes.each do |res|
    #    		html += "<div style='border-bottom:1px solid #ccc;padding:22px;'>"
    # 			html += link_to "#{res.cv_file_name}", resume_path(res)
    # 			# html += link_to "#{res.cv_file_name}", "/resumes/#{res.id}/download?job_id=#{job.id}"
    # 			html += "</div>"
    #    	end
    #   	end
    # end
    html += "<div style='padding:22px;'>"
    html += link_to "Review/Create INTERVIEW stage",job_path(job)
    html += "</div>"
    html.html_safe
  end


  def cv_download_admin_section job
    html = ""
    reviews = Review.where(job_id: job.id)
    reviews.each do |review|
      unless review.is_cv_download
        html += "CV awaiting download"
      else
        resumes = review.user.resumes.where(id: review.cv_ids)
        resumes.each do |res|
          html += link_to "#{res.cv_file_name}", admin_resume_path(res)
          # html += link_to "#{res.cv_file_name}", "/resumes/#{res.id}/download?job_id=#{job.id}"
          html += "<br>"
        end
      end
    end
    html.html_safe
  end


  def interview_stage_client_section(job)
    html = ""
    if job.interview.present?
      reviews = Review.where(job_id: job.id)
      reviews.each do |review|
        stage = job.interview.interview_schedules.where(user_id: review.user_id).maximum("stage")
        html +=	"<div style='padding:22px;'>"
        if stage.present?

          html += "<b> pre screen </b> round<br>" if stage.zero?
          html += "<b>"+stage.try(:ordinalize)+"</b> round<br>" unless stage.zero?
        end
        html += link_to "view schedule","/interview_schedules/#{job.id}?user_id=#{review.user_id}"  if current_user.present?
        html += link_to "view schedule", admin_client_job_schedules_path(review.user,job) unless current_user.present?
        html += "</div>"
      end

    end
    html.html_safe
  end


  def new_desing_interview_stage_client_section(job, user_id)
    html = ""
    if job.interview.present?
      reviews = Review.where(job_id: job.id, user_id: user_id)
      if reviews.present?
        reviews.each do |review|
          job_totla_stage = job.interview.total_stage || 0
          stage = job.interview.interview_schedules.where(user_id: review.user_id).maximum("stage").to_i + 1
          html +=	"<ul class='d-block'>"
          html +=	"<h3>Interview schedule &nbsp;&nbsp;&nbsp;"
          # html += link_to "Create","/interview_schedules/#{job.id}?user_id=#{review.user_id}"  if current_user.present?
          html += "<a data-toggle='modal' data-target='#interview-round' href='#'>Create</a>" if current_user.present?
          html +=	"/" if job.interview.interview_schedules.where(user_id: review.user_id).present?
          html += link_to "Edit","/interview_schedules/#{job.id}?user_id=#{review.user_id}"  if job.interview.interview_schedules.where(user_id: review.user_id).present?
          html +=	"</h3>"

          html +=	" <div class='stepwizard'><div class='stepwizard-row'>"
          (1..3).each do |item|
            color = (item.to_i <= stage.to_i) ? '<i class="fas fa-check"></i>' : ''
            html += "<div class='stepwizard-step'><button type='button' class='btn btn-default btn-circle'> #{color}</button><p>#{item.to_i.ordinalize}</p></div>"
          end
        end
      else
        html +=	"<ul class='d-block'>"
        html +=	"<h3>Interview schedule &nbsp;&nbsp;&nbsp;"
        #html += link_to "Create","javascript:void(0)"
        html +=	"</h3>"
        html +=	" <div class='stepwizard'><div class='stepwizard-row'>"
        (1..3).each do |item|
          html += "<div class='stepwizard-step'><button type='button' class='btn btn-default btn-circle' ></button><p>#{item.to_i.ordinalize}</p></div>"
        end
      end
    else

      html +=	"<ul class='d-block'>"
      html +=	"<h3>Interview schedule &nbsp;&nbsp;&nbsp;"
      html +=	"</h3>"
      html +=	" <div class='stepwizard'><div class='stepwizard-row'>"
      (1..3).each do |item|
        html += "<div class='stepwizard-step'><button type='button' class='btn btn-default btn-circle' ></button><p>#{item.to_i.ordinalize}</p></div>"
      end

    end
    html += "</div></div></ul>"
    html.html_safe
  end

  def new_desing_meeting_with(job, user_id)
    @job = Job.find(job.id)
    @user = User.find(user_id) if current_user.client?
    html = "<h3>Pre Screen Note &nbsp;&nbsp;"
    if @job.interview.present?
      #@schedule = @job.interview.interview_schedules.where(user_id: user_id).last if current_user.client?
      #@schedule = @job.interview.interview_schedules.first if current_user.client?
      #@last_stage = @schedules.maximum('stage') if current_user.client?
      #if current_user.client? && @schedule.present? and @schedule.stage != 0
      if @job.interview.pre_screen_notes.where(user_id: user_id).present?
        #recent_comment = @schedule.client_comments.first
        note = @job.interview.pre_screen_notes.where(user_id: user_id).first
        add = "<a href='javascript:void(0);' onclick='setPreScreenNoteDetails(this);' data-toggle='modal' data-target='#pre-screen-note' data-note-id='' data-note=''  data-interview-id='#{@job.interview.id}' data-user-id='#{user_id}' data-review='1'>Add</a>"
        edit = "<a href='javascript:void(0);' onclick='setPreScreenNoteDetails(this);' data-toggle='modal' data-target='#pre-screen-note' data-note-id='#{note.id}' data-note='#{note.note}'  data-interview-id='#{@job.interview.id}' data-user-id='#{user_id}' data-review='1'>Edit</a>"
        html += 	@job.interview.pre_screen_notes.where(user_id: user_id).present? ? "#{edit}" : "#{add}"
        html +=	"<p data-toggle='tooltip' data-placement='bottom' title='#{note.note}'>#{note.note.truncate(20)}</p>"
      else
        html += "<a href='javascript:void(0);' onclick='setPreScreenNoteDetails(this);' data-toggle='modal' data-target='#pre-screen-note' data-note-id='' data-note=''  data-interview-id='#{@job.interview.id}' data-user-id='#{user_id}' data-review='1'>Add</a>"
        html +=	"<p title=''></p>"
      end
      #end
    end
    html += "</h3>"
    html.html_safe
  end

  def meeting_with(job)
    html = "<p style='height:0px;margin-top:-10px;'></p>"
    if job.interview.present?
      reviews = Review.where(job_id: job.id)
      reviews.each do |review|
        unless job.interview_schedules.where(user_id: review.user_id).empty?
          add = "<div style='padding:30px;'><button onclick='meeting_with(#{review.id},\"\")' class='btn btn-primary' id='myBtn'>Add</button>"
          edit = "<button onclick='meeting_with(#{review.id},\"#{review.meeting}\")' class='btn btn-primary' id='myBtn'>Edit</button>"
          html +=	review.meeting.present? ? "<div style='padding:21px;'><a href='#' data-toggle='tooltip' data-placement='bottom' title='#{review.meeting}'>#{review.meeting.truncate(70)}</a>"+edit : add
        else
          html +=	"<div style='padding:30px;'>No"
        end
        html += "</div>"
      end
    end
    html.html_safe
  end

  def candidate_interview_status

    html = "<div class='box-footer'>
                  <ul class='d-block'>
                     <h3>Interview Status&nbsp;&nbsp;&nbsp;<a href='#' data-toggle='modal' data-target='#schedule' style='display: inline-block;'>view</a></h3>
                     <div class='stepwizard'>
                        <div class='stepwizard-row'>
                           <div class='stepwizard-step'>
                              <button type='button' class='btn btn-default btn-circle'><i class='fas fa-check'></i></button>
                              <p>1st</p>
                           </div>
                           <div class='stepwizard-step'>
                              <button type='button' class='btn btn-circle'><i class='fas fa-check'></i></button>
                              <p>2nd</p>
                           </div>
                           <div class='stepwizard-step'>
                              <button type='button' class='btn btn-default btn-circle' disabled='disabled'></button>
                              <p>3rd</p>
                           </div>
                           <div class='stepwizard-step'>
                              <button type='button' class='btn btn-default btn-circle' disabled='disabled'></button>
                              <p>4th</p>
                           </div>
                           <div class='stepwizard-step'>
                              <button type='button' class='btn btn-default btn-circle' disabled='disabled'></button>
                              <p>5th</p>
                           </div>
                        </div>
                     </div>
                  </ul>
               </div>"

    html.html_safe
  end
end
