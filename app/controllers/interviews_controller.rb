class InterviewsController < ApplicationController
	before_action :authenticate_user!
	before_action :set_job
  def new
  end 

	def create
		if @job.interview.present?
			@job.interview.update(inteview_params)
      if inteview_params[:total_stage].to_i == 1
        unless @job.interview.interview_schedules.where(user_id: params[:candidate_id]).present?
          InterviewSchedule.create(stage: 1,interview_id: @job.interview.id,user_id: params[:candidate_id]) 
        else
          schedule = @job.interview.interview_schedules.where(user_id: params[:candidate_id]).first
          schedule.update(stage: 1)
        end
      else
        InterviewSchedule.create(stage: inteview_params[:total_stage],interview_id: @job.interview.id,user_id: params[:candidate_id])
      end
		else
  		@job.build_interview(inteview_params).save
      if inteview_params[:total_stage].to_i == 1
        schedule = @job.interview.interview_schedules.where(user_id: params[:candidate_id]).first
        schedule.update(stage: 1)
      else
        InterviewSchedule.create(stage: inteview_params[:total_stage],interview_id: @job.interview.id,user_id: params[:candidate_id])
      end
    end
    #flash[:notice] =  "stage should be between 1 to 10" unless job.present?
  	redirect_to job_path(@job,user_id: params[:candidate_id])
	end

	def set_job
		@job = Job.find params[:job_id]
	end

	private

	def inteview_params
		params.require(:interview).permit(:total_stage)
	end
end
