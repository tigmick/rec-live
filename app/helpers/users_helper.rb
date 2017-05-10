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
	  		html += "<b> pre screen </b> round<br>" if stage.zero? 
    		html += "<b>"+stage.try(:ordinalize)+"</b> round<br>" unless stage.zero?
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

	def meeting_with(job)
    html = "<p style='height:0px;margin-top:-10px;'></p>"
		if job.interview.present?
			reviews = Review.where(job_id: job.id)
			reviews.each do |review|
				unless job.interview_schedules.where(user_id: review.user_id).empty? 
				add = "<div style='padding:30px;'><button onclick='meeting_with(#{review.id},\"\")' class='btn btn-primary' id='myBtn'>Add</button>"
				edit = "<button onclick='meeting_with(#{review.id},\"#{review.meeting}\")' class='btn btn-primary' id='myBtn'>Edit</button>"
				html +=	review.meeting.present? ? "<div style='padding:21px;'><a href='#' data-toggle='tooltip' data-placement='bottom' title='#{review.meeting}'>#{review.meeting.truncate(40)}</a>"+edit : add
		  	else
		  	html +=	"<div style='padding:30px;'>No"
		  	end
		  	html += "</div>"
		  end
		end 
		html.html_safe
	end
end
