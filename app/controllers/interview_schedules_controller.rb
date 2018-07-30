class InterviewSchedulesController < ApplicationController
  before_action :authenticate_user!
  def create
    @date_hash = {}
    (1..params[:date_count].to_i).each do |val|
      # instance_variable_set("@_interview_avail_date#{val}", params["interview_avail_date#{val}"])
      @date_hash["interview_avail_date#{val}"] = params["interview_avail_date#{val}"]
    end
    interview = Interview.find(params[:interview_id])
    unless params[:scheds_id].present?
      schedule = interview.interview_schedules.new(
        stage: params[:stage],
        interview_avail_dates: @date_hash,
        interviewers_names: params[:interviewer_names].split(","),
        user_id:  params[:user_id]
      )
      schedule.save
      schedule.interview.update_attribute(:total_stage, params[:stage])
      UserMailer.interview_schedules(schedule.interview.job.user, schedule.id).deliver_now
      UserMailer.interview_schedules(User.find(schedule.user_id), schedule.id).deliver_now
      UserMailer.interview_schedules(AdminUser.first, schedule.id).deliver_now
    else
      schedule = InterviewSchedule.find params[:scheds_id]
      schedule.update(interviewers_names: params[:interviewer_names].split(","),interview_avail_dates: @date_hash)
    end
    @job = interview.job
    #flash[:notice] = schedule.errors.messages  unless schedule.present?
    #redirect_to"/interview_schedules/#{interview.job.id}?user_id=#{params[:user_id]}"
    #redirect_to "/users/dashboard"
    # redirect_to "/interview_schedules/#{params[:user_id]}/user_profile?job_id=#{interview.job.id}&review=true"
  end

  def show
    @job = Job.find(params[:id])
    @user = User.find(params[:user_id]) if current_user.client?
    @schedules = @job.interview.interview_schedules.where(user_id: current_user.id) if current_user.candidate?
    @schedules = @job.interview.interview_schedules.where(user_id: params[:user_id]) if current_user.client?
    @last_stage = @schedules.maximum('stage') if current_user.client?
  end

  def candidate_feedback
    @schedule = InterviewSchedule.find(params[:schedule_id])
    unless params[:feedback_id].present?
      #user_id = current_user.client? ? schedule.interview.job.user.id :  schedule.user_id
      candidate_feedback = @schedule.candidate_feedbacks.new(user_id: current_user.id,client: current_user.client? ,feedback: params[:feedback])
      candidate_feedback.save
      UserMailer.candidate_feedback(candidate_feedback,@schedule.interview.job.user).deliver_now
      UserMailer.candidate_feedback(candidate_feedback,current_user).deliver_now
      UserMailer.candidate_feedback(candidate_feedback,AdminUser.first).deliver_now
    else
      candidate_feedback=CandidateFeedback.find(params[:feedback_id])
      candidate_feedback.update(user_id: current_user.id,feedback: params[:feedback])
    end
    #redirect_to interview_schedule_path(schedule.interview.job) if current_user.candidate?
    #redirect_to "/interview_schedules/#{schedule.interview.job.id}?user_id=#{schedule.user_id}" if current_user.client?
    #redirect_to "/users/dashboard#"
  end


  def destroy_feedback
    candidate_feedback=CandidateFeedback.find(params[:id])
    @schedule = candidate_feedback.interview_schedule
    candidate_feedback.destroy
    #redirect_to interview_schedule_path(candidate_feedback.interview_schedule.interview.job) if current_user.candidate?
    #redirect_to "/interview_schedules/#{candidate_feedback.interview_schedule.interview.job.id}?user_id=#{candidate_feedback.interview_schedule.user_id}" if current_user.client?
    #redirect_to "/users/dashboard#"
  end


  def client_comment
    @schedule = InterviewSchedule.find(params[:sched_id])
    unless params[:comment_id].present?
      user_id = current_user.client? ? current_user.id : @schedule.user_id
      client_comment = @schedule.client_comments.new(user_id: user_id,client: current_user.client? ,comment: params[:comment])
      client_comment.save
      UserMailer.client_comment(client_comment,@schedule.interview.job.user).deliver_now
      UserMailer.client_comment(client_comment,User.find(@schedule.user_id)).deliver_now
      UserMailer.client_comment(client_comment,AdminUser.first).deliver_now
    else
      client_comment=ClientComment.find(params[:comment_id])
      client_comment.update(comment: params[:comment])
    end

    #    respond_to do |format|
    #      format.html do
    #        redirect_to interview_schedule_path(schedule.interview.job) if current_user.candidate?
    #        #redirect_to "/interview_schedules/#{schedule.interview.job.id}?user_id=#{schedule.user_id}" if current_user.client?
    #        redirect_to "/users/dashboard" if current_user.client?
    #      end
    #      format.json do
    #        render json: client_comment, status: :ok
    #      end
    #    end
  end
  
  def pre_screen_note
    unless params[:note_id].present?
      pre_screen_note = PreScreenNote.new(note: params[:note],interview_id: params[:p_interview_id])
      pre_screen_note.save
      flash[:notice] = "Pre screen note is added successfully."
    else
      pre_screen_note=PreScreenNote.find(params[:note_id])
      pre_screen_note.update(note: params[:note])
      flash[:notice] = "Pre screen note is updated successfully."
    end
    redirect_to "/users/dashboard"
  end

  def destroy_comment
    client_comment=ClientComment.find(params[:id])
    @schedule = client_comment.interview_schedule 
    client_comment.destroy
    #redirect_to interview_schedule_path(client_comment.interview_schedule.interview.job) if current_user.candidate?
    #redirect_to "/users/dashboard" if current_user.client?

  end

  def next_step
    schedule = InterviewSchedule.find(params[:sched_id])
    schedule.update(next_step: params[:next_step], next_step_desc: params[:next_step_desc])
    UserMailer.interview_schedules(schedule.id).deliver_now unless schedule.errors.empty?
    flash[:notice] = schedule.errors.messages
    redirect_to "/interview_schedules/#{schedule.interview.job.id}?user_id=#{schedule.user_id}"
  end

  def destroy
    schedule = InterviewSchedule.find(params[:id])
    @job = schedule.interview.job
    schedule.destroy
    #redirect_to"/users/dashboard"
  end
  
  def populate_interview_schedule_popup
    @job = Job.find(params[:job_id])
    @interview_schedules = @job.interview.interview_schedules.where(user_id: params[:user_id]) 
  end
  
  def candidate_interview_schedule_popup
    @job = Job.find(params[:job_id])
  end

  def meeting
    review = Review.find(params[:review_id])
    review.update(meeting: params[:meeting])
    redirect_to users_dashboard_path
  end
end
