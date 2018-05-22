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
	  		de
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
		html = review.present? ? "<b>Yes</b> on <b>Date: #{review.cv_download_date.strftime('%d/%m/%Y %-I:%M%p')}</b>" : "<b>CV awaiting download</b>"
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
					html += link_to "create","/interview_schedules/#{job.id}?user_id=#{review.user_id}"  if current_user.present?
					html +=	"/" if job.interview.interview_schedules.where(user_id: review.user_id).present?
					html += link_to "edit","/interview_schedules/#{job.id}?user_id=#{review.user_id}"  if job.interview.interview_schedules.where(user_id: review.user_id).present?
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
				html += link_to "create","javascript:void(0)"
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
    	html = "<h3>Interview notes &nbsp;&nbsp;"
    	if job.interview.present?
    		reviews = Review.where(job_id: job.id, user_id: user_id)
    		#if reviews.present?
	    		reviews.each do |review|
	    			unless job.interview_schedules.where(user_id: user_id).empty? 
						add = "<a href='javascript:void(0);' onclick='meeting_with(#{review.id},\"\")' id='myBtn'>Add</a>"
						edit = "<a href='javascript:void(0);' onclick='meeting_with(#{review.id},\"#{review.meeting}\")' id='myBtn'>Edit</a>"
						html += 	review.meeting.present? ? "#{add}/#{edit}" : "#{add}"
						if review.meeting.present?
							html +=	"<p title='#{review.meeting}'>#{review.meeting.truncate(70)}</p>"
						else
							html +=	"<p title='No review'>No review</p>"
						end
			end
    		end
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
end
