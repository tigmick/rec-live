class UserMailer < ApplicationMailer
  def resume_download resource,job_id,candidate=nil
    @job = Job.find(job_id)
    @client_email  = User.find(@job.user_id).email
    @subject = "CV Download"
    @candidate = candidate unless candidate.nil?
    @resource = resource
    mail(from: @client_email,to: resource.email, subject: @subject)
  end

  def assign_job resource,user,job
    @resource = resource
    @user = user
    @job = job
    @subject = "Job Assign Successfully"
    mail(from: @user.email,to: @resource.email, subject: @subject)
  end

  def un_assign_job resource,user
    @resource = resource
    @user = user
    @subject = "Job UN-Assign"
    mail(from: @user.email,to: @resource.email, subject: @subject)
  end

  def job_applied resource,job_id
    @resource = resource
    @job = Job.find(job_id)
    (resource.first_name.present? rescue false) ? (@resource = User.find(@job.user_id)) : @resource
    @subject = "Job Appiled successfully"
    mail(from: AdminUser.first.email,to: @resource.email, subject: @subject)
  end

  def review_mail candidate,job_id
    @job = Job.find(job_id)
    @client_email  = User.find(@job.user_id).email
    @candidate_eamil = User.find(candidate).email
    @subject = "profile reviews"
    mail(from: @client_email,to: @candidate_eamil, subject: @subject)
  end

  def client_comment comment,resource
    @resource = resource
    html = "New Update on Job title - ( Job title)"
    html += "The update - ( #{comment.comment})"
    @content = html
    @subject = "You've one comment"
    @comment  =  comment
    mail(from: AdminUser.first.email,to: @resource.email ,subject: @subject)
  end

  def candidate_feedback feedback, resource
    @resource = resource
    html = "New Update on Job title - ( Job title)"
    html += "The update - ( #{feedback.feedback})"
    @content = html
    @subject = "You've one feedback"
    mail(from: AdminUser.first.email,to: @resource.email, subject: @subject)
  end

  def job_creation(job)
    @job = job
    @client = User.find(job.user_id)
    @subject = "New Job Created"
    mail_to = AdminUser.first.email
    mail(from: @client.email,to: mail_to, subject: @subject)
  end
  def interview_schedules(resource, schedule_id)
    @resource = resource
    @schedule = InterviewSchedule.find(schedule_id)
    @candidate = User.find(@schedule.user_id)
    @client = @schedule.interview.job.user
    @subject = "You've Interview Schedule"
    mail(from: AdminUser.first.email,to: @resource.email, subject: @subject)
  end

  def accepted_email(user_id, job_id)
    @user = User.find user_id
    @job = Job.find job_id
    mail(to: email_with_name(@user.email, @user.full_name), subject: "Accpeted for job #{@job.title}")
  end

  def candidate_email_alert(resource, user)
    @resource = resource
    if (resource.first_name.present? rescue false)
      html = "Thanks for registering on MYPHD.<br>"
      html += "Username - #{resource.first_name}<br>"
      html += "Email    - #{resource.email}<br>"
      html += "password - #{resource.password}<br>"
      @content = html
      @subject = resource.role.upcase + ' EMAIL ALERT REGISTRATION'
      mail(from: AdminUser.first.email, to: resource.email, subject: @subject)
    else
      html = "New User have registered on your site.<br>"
      html += "Username     - #{user.first_name}<br>"
      html += "Last Name    - #{user.last_name}<br>"
      html += "Email        - #{user.email}<br>"
      html += "password     - #{user.password}<br>"
      html += "Contact No   - #{user.contact_no}<br>"
      html += "Job Title    - #{user.job_title}<br>"
      html += "Company Name - #{user.company_name}<br>"
      html += "Location     - #{user.current_location}<br>"
      # html +="Username."
      @content = html
      @subject = user.role.upcase + " EMAIL ALERT REGISTRATION"
      #mail(from: AdminUser.first.email, to: 'chris.forbes@phdit.com', subject: @subject)
    end
  end
end
