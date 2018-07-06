class JobMailer < ApplicationMailer
  def accepted_email(user_id, job_id)
    @user = User.find user_id
    @job = Job.find job_id
    mail(to: email_with_name(@user.email, @user.full_name), subject: "Accpeted for job #{@job.title}")
  end
  def rejected_email(user_id, job_id)
    @user = User.find user_id
    @job = Job.find job_id
    mail(to: email_with_name(@user.email, @user.full_name), subject: "You have been rejected for job #{@job.title} , you can try again.")
  end
end
