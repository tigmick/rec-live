class UserJobsController < ApplicationController
	before_action :authenticate_user!
	def create
		@job_id = params[:job_id]
		job = Job.find params[:job_id]
		unless current_user.resumes.empty? || job.closed?
#			if current_user.user_job.nil? || current_user.user_job.job_ids.empty?
#				user_job = current_user.build_user_job(job_ids: [@job_id.to_i])
#				user_job.save
#				UserMailer.job_applied(current_user,@job_id).deliver_now
#				UserMailer.job_applied(AdminUser.first,@job_id).deliver_now
#			else
#				job_ids = current_user.user_job.job_ids.push(@job_id.to_i)
#				current_user.user_job.update(job_ids: job_ids)
#				UserMailer.job_applied(current_user,@job_id).deliver_now
#				UserMailer.job_applied(AdminUser.first,@job_id).deliver_now
#			end
        current_user.job_applications.create(candidate_id: current_user.id,job_id: params[:job_id])
				UserMailer.job_applied(current_user,@job_id).deliver_now
				UserMailer.job_applied(AdminUser.first,@job_id).deliver_now
		else
			if job.closed?
				@error_msg = "Job has been closed and no longer available."
			else
				@error_msg = "You must Upload a CV to Apply for a Job Goto Your Dashboard and Upload now"
			end
		end
		respond_to do |format|
			format.js
		end
	end
end
