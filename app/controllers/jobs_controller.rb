class JobsController < ApplicationController
  include JobsHelper
  before_action :set_job, only: [:show, :edit, :update, :destroy, :close_job, :open_job]
  before_action :authenticate_user!, except: [:download]


  # GET /Jobs
  # GET /Jobs.json
  def index

    job_ids = AssignJob.all.collect{|k| k.user_ids.include?(current_user.id) ? k.job_id : []}.flatten
    @jobs = Job.all.order('created_at desc')
    if current_user.client? 
      @jobs =  current_user.jobs.order('created_at desc')
      @jobs << Job.where('id IN (?)',job_ids)
      @jobs = @jobs.flatten
    end
  end

  # GET /Jobs/1
  # GET /Jobs/1.json
  def show
    @users = UserJob.all.collect{|k| k.job_ids.include?(@job.id) ? User.find(k.user_id) : []}.flatten
    @interview = Interview.new
    @schedules =  @job.interview.present? ? @job.interview.interview_schedules : []
  end

  # GET /Jobs/new
  def new
    @job = Job.new
  end

  # GET /Jobs/1/edit
  def edit
    
  end

  # POST /Jobs
  # POST /Jobs.json
  def create
    @job = current_user.jobs.new(job_params)

    respond_to do |format|
      if @job.save
        UserMailer.job_creation(@job).deliver_now 
        format.html { redirect_to @job, notice: 'Job was successfully created.' }
        format.json { render :show, status: :created, location: @job }
      else
        format.html { render :new }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /Jobs/1
  # PATCH/PUT /Jobs/1.json
  def update
    respond_to do |format|
      if @job.update(job_params)
        format.html { redirect_to @job, notice: 'Job was successfully updated.' }
        format.json { render :show, status: :ok, location: @job }
      else
        format.html { render :edit }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /Jobs/1
  # DELETE /Jobs/1.json
  def destroy
    @job.destroy
    respond_to do |format|
      format.html { redirect_to jobs_url, notice: 'Job was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def download
    doc = Job.find(params[:id])
    file = File.open(open("#{doc.document.path}"))
    data = file.read
    # doc.track_resume(params[:job_id])  if current_user.client? 
    send_data(data, :type => "application/#{doc.document.path.split(".").last}", :filename => "#{doc.document_file_name}", :x_sendfile=>true)
    return
  end

  def close_job
    if (current_user.client? && @job.user_id == current_user.id)
      @job.update status: 1, closed_at: Time.now
      redirect_to '/jobs'
    else
      flash[:error] = 'Action not permitted'
      redirect_to '/jobs'
    end
  end

  def open_job
    if (current_user.client? && @job.user_id == current_user.id)
      @job.update status: 0, closed_at: nil
      redirect_to '/jobs'
    else
      flash[:error] = 'Action not permitted'
      redirect_to '/jobs'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_job
      @job = Job.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def job_params
      params.require(:job).permit(:title, :description,:industry_id,:document)
    end
end
