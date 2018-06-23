class UsersController < ApplicationController
  include UsersHelper
	before_action :check_reviews, only: :user_profile  
  def dashboard
    @industries = Industry.all
    @user = current_user
    if current_user.client?
      job_ids = AssignJob.all.collect{|k| k.user_ids.include?(current_user.id) ? k.job_id : []}.flatten
      @jobs = current_user.jobs.order('created_at desc')
      @jobs << Job.where('id IN (?)',job_ids)
      @jobs = @jobs.flatten
    else
      @applied_jobs = @user.candidate_jobs
      #@applied_jobs = current_user.user_job.present? ? Job.where(id: current_user.user_job.job_ids) : [] 
      @reviews = Review.joins(:job).where(user_id: @user.id).select("id","job_id","jobs.user_id","created_at","cv_download_date")
    end
    render layout: 'new_ui/application'
  end

  def user_profile
  	@user =  User.find(params[:id])
  	if params[:job_id].present?
      @job = Job.find(params[:job_id])
    end
    render layout: 'new_ui/application'
  end

  def check_reviews
  	if params[:review].present?
  		review = Review.find_or_create_by(job_id: params[:job_id], user_id: params[:id])
      is_review = review.is_review 
      review.update(is_review: true, review_count: (review.review_count.to_i+1))
 	    UserMailer.review_mail(params[:id], params[:job_id]).deliver_now if (is_review && review.created_at == review.updated_at)
    end
  end
end
