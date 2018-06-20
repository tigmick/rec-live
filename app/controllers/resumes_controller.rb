class ResumesController < ApplicationController

  before_action :set_resume, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /resumes
  # GET /resumes.json
  def index
    @resumes = current_user.resumes
    if current_user.client?
      @resumes = User.find(params[:user_id]).resumes
      @job = Job.find(params[:job_id])
    end
  end

  # GET /resumes/1
  # GET /resumes/1.json
  def show
  end

  # GET /resumes/new
  def new
    @resume = Resume.new
    render layout: 'new_ui/application'
  end

  # GET /resumes/1/edit
  def edit
  end

  # POST /resumes
  # POST /resumes.json
  def create
    @resume = current_user.resumes.new(resume_params)
    respond_to do |format|
      if @resume.save
        format.html { redirect_to @resume, notice: 'Resume was successfully created.' }
        format.json { render :show, status: :created, location: @resume }
      else
        format.html { render :new }
        format.json { render json: @resume.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /resumes/1
  # PATCH/PUT /resumes/1.json
  def update
    respond_to do |format|
      if @resume.update(resume_params)
        format.html { redirect_to @resume, notice: 'Resume was successfully updated.' }
        format.json { render :show, status: :ok, location: @resume }
      else
        format.html { render :edit }
        format.json { render json: @resume.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /resumes/1
  # DELETE /resumes/1.json
  def destroy
    @resume.destroy
    respond_to do |format|
      format.html { redirect_to resumes_url, notice: 'Resume was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def download
    doc = Resume.find(params[:id])
    file = File.open(open("#{doc.cv.path}"))
    data = file.read
    doc.track_resume(params[:job_id])  if (params[:job_id].present?) 
    send_data(data, :type => "application/#{doc.cv.path.split(".").last}", :filename => "#{doc.cv_file_name}", :x_sendfile=>true)
    return
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_resume
      @resume = Resume.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def resume_params
      params.require(:resume).permit(:title, :description,:cv)
    end
end
