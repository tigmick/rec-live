class InterviewsController < ApplicationController
	before_action :authenticate_user!
	before_action :set_job
  def new
  end 

	def create
		if @job.interview.present?
			job = @job.interview.update(inteview_params)
      if inteview_params[:total_stage].to_i == 1
        schedule = @job.interview.interview_schedules.first
        schedule.update(stage: 1)
      else
        InterviewSchedule.create(stage: inteview_params[:total_stage],interview_id: @job.interview.id,user_id: current_user.id)
      end
		else
  		job = @job.build_interview(inteview_params).save
      if inteview_params[:total_stage].to_i == 1
        schedule = @job.interview.interview_schedules.first
        schedule.update(stage: 1)
      else
        InterviewSchedule.create(stage: inteview_params[:total_stage],interview_id: @job.interview.id,user_id: current_user.id)
      end
    end
    flash[:notice] =  "stage should be between 1 to 10" unless job.present?
  	redirect_to job_path(@job)
	end

	def set_job
		@job = Job.find params[:job_id]
	end

	private

	def inteview_params
		params.require(:interview).permit(:total_stage)
	end
end
