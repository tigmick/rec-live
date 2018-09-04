class UsersController < ApplicationController
  include UsersHelper
  require 'prawn'
  include PrawnResumeHelper
  before_action :check_reviews, only: :user_profile

  def create
    require 'open-uri'
    @auth = env["omniauth.auth"]
    number = (0...6).map { (65 + rand(26)).chr }.join
   begin
      @user = User.where(email: @auth.info.email)
      if !@user.present?
        @user = User.where(provider: @auth.provider, uid: @auth.uid).first_or_initialize do |user|
          user.provider = @auth.provider
          user.uid = @auth.uid
          user.first_name = @auth.info.first_name
          user.last_name = @auth.info.last_name
          user.email = @auth.info.email
          user.current_location = @auth.info.location
          user.contact_no = @auth.info.phone
          user.oauth_token = @auth.credentials.token
          user.oauth_expires_at = ""
          user.image = open(@auth.info.image) if @auth.info.image.present?
          user.password = number
          user.password_confirmation = number 
          user.role = "candidate"
          user.save(validate: false)
          pdf = InvoicingAndReceipts.new("RESUME", @user,@auth)
          abc = Base64.strict_encode64(pdf.render)
          decoded_file = Base64.decode64(abc)
          file = Tempfile.new(["#{user.first_name}",'.pdf'], Rails.root.join('tmp'))
          file.binmode
          file.write pdf.render
          file.close
          pdf = File.open file
          pdf_file_name = "#{user.first_name}.pdf"
          rr = Resume.new(cv: pdf, user_id: user.id)
          rr.save
          file.unlink
          UserMailer.candidate_email_alert(user, nil).deliver_now
        end
        sign_in(@user)
        redirect_to root_path, notice: "Welcome! You have signed up Sucessfully and we have email your login Details on your email."
      elsif @user.present?
        sign_in(@user.first)
        redirect_to root_path, notice: "Welcome! You are alredy Register."
      else
        redirect_to root_path, alert: "Sign Up Failed please try again!"
      end
    rescue Exception => e
      redirect_to root_path, alert: e.message
    end
    
  end
  def dashboard
    @industries = Industry.all
    @user = current_user
    if current_user.client?
      job_ids = AssignJob.all.collect{|k| k.user_ids.include?(current_user.id.to_s) ? k.job_id : []}.flatten
      @jobs = current_user.jobs.order('created_at desc')
      @jobs << Job.where(id: job_ids)
      @jobs = @jobs.flatten
      @clients = User.where(role: "client")
    else
      #@applied_jobs = @user.candidate_jobs
      #@applied_jobs = current_user.user_job.present? ? Job.where(id: current_user.user_job.job_ids) : []
      @applied_jobs = current_user.applied_jobs
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
