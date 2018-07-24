module InterviewSchedulesHelper
	def client_comment_helper schedule
    html = ""
    
    unless schedule.client_comments.empty?
      schedule.client_comments.each do |comment|
        html += "<div><b>#{comment.user.first_name}</b> : <a href='#' data-toggle='tooltip' data-placement='bottom' title='#{comment.comment}'>#{comment.comment.truncate(75).capitalize}</a></div>"
        html += "<button onclick='show(#{schedule.id},#{comment.id},\"#{comment.comment}\")' class='btn btn-primary' id='myBtn'>Edit</button>  #{link_to 'Delete',destroy_comment_path(comment),method: :delete}<br>"  if current_user.id.eql?(comment.user_id)
      end	
      html += "<button onclick='show(#{schedule.id},\"\",\"\")' class='btn btn-primary' id='myBtn'>Add comment</button>"  if current_user.client?
    else
      html += "<button onclick='show(#{schedule.id},\"\",\"\")' class='btn btn-primary' id='myBtn'>Add comment</button>" if current_user.client?
    end
		html.html_safe
  end


	def candidate_feedback_helper schedule
	  html = ""
    unless schedule.candidate_feedbacks.empty?
      schedule.candidate_feedbacks.each do |feedback|
        html +=  "<div><b>#{feedback.user.first_name}</b> : <a href='#' data-toggle='tooltip' data-placement='bottom' title='#{feedback.feedback}'>#{feedback.feedback.truncate(75).capitalize}</a></div>"
        html += "<button onclick='feedback(#{schedule.id},#{feedback.id},\"#{feedback.feedback}\")' class='btn btn-primary' id='myBtn'>edit</button>  #{link_to 'delete',destroy_feedback_path(feedback),method: :delete}<br>"  if current_user.id.eql?(feedback.user_id)
      end	
      html += "<button onclick='feedback(#{schedule.id},\"\",\"\")' class='btn btn-primary' id='myBtn'>Add feedback</button>" unless current_user.client?
    else
      html += "<button onclick='feedback(#{schedule.id},\"\",\"\")' class='btn btn-primary' id='myBtn'>Add feedback</button>" unless current_user.client?
    end
    html.html_safe
	end


	def next_step_helper schedule
		html = ""
		html += "Next Step: #{schedule.next_step}<br>" if schedule.next_step.present?
		html += "Description: #{schedule.next_step_desc}<br>" if schedule.next_step_desc.present?
		if current_user.client?
			# unless schedule.stage.zero?
      html += " <button onclick='next_step(#{schedule.id},\"#{schedule.stage}\",#{schedule.interviewers_names},#{schedule.interview_avail_dates.to_json})' class='btn btn-primary' id='myBtn'>Edit </button>"
      if schedule.stage.eql?(@last_stage)
       	
        html += " <button onclick='next_step(\"\",\"#{schedule.stage+1}\",\"\",\"\")' class='btn btn-primary' id='myBtn'>Add</button> "  unless schedule.stage.eql? @job.interview.total_stage
      end
      html += "  "
      html += link_to " Delete", "/interview_schedules/#{schedule.id}", method: :delete 
      # else
      # 	if schedule.stage.eql?(@last_stage)
      #     html += " <button onclick='next_step(\"\",\"#{schedule.stage+1}\",\"\",\"\")' class='btn btn-primary' id='myBtn'>Add</button>"
      # 	end
      # end
		end
		html.html_safe
	end
  
  def detect_stage(stage)
    case stage # a_variable is the variable we want to compare
    when 1    
      "1st Round" 
    when 2    
      "2nd Round"
    when 3    
      "3rd Round"
    when 4    
      "4th Round"
    when 5    
      "5th Round"
    when 6    
      "6th Round"
    when 7    
      "7th Round"
    when 8    
      "8th Round"
    when 9    
      "9th Round"
    when 10    
      "10th Round"
    end
  end

  def populate_date_for_tooltip(dates,stage)
    
    @date = ""
    dates.each do |date|
      if date.key?(stage.to_s)  
        @date = date[stage.to_s]
      end      
    end
    return @date
  end
end
