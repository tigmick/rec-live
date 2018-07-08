class AssignJobsController < ApplicationController
	def new
		@users = User.where.not(role: 'candidate', id: current_user.id)
    @job = Job.find params[:job_id]
    @assign_job = AssignJob.find_by_job_id(@job.id)
    @assign_users = AssignJob.find_by_job_id(@job.id).user_ids rescue []
	end

	def remove_assign
		@user = User.find params[:user_id]
		@assign_job = AssignJob.find params[:id]
		@assign_job.user_ids.delete(@user.id)
		@assign_job.update_attributes(user_ids: @assign_job.user_ids)
		UserMailer.un_assign_job(@user,current_user).deliver_now
    respond_to do |format|
      format.js
    end
	end
	def create
		@job = Job.find params[:job_id]
    if @job.assign_job.present?  
      @assign_job = @job.assign_job
      #@assign_job.update_attributes(user_ids: @job.assign_job.user_ids.push(params[:user_ids]))
      @assign_job.update_attributes(user_ids: params[:user_ids])
      @users = User.where(params[:user_id])
      @users.each do |user|
        UserMailer.assign_job(user,current_user,@job).deliver_now
      end
		else
		  @assign_job = @job.build_assign_job(user_ids: params[:user_ids])
		  @assign_job.save
    end
    redirect_to "/jobs"
	end


end
