class WelcomeController < ApplicationController
	include WelcomeHelper
  layout "new_ui/application"#, only: [:index, :search, :search_candidate]
  
  def index
  end

  def search
    if params[:search].present? && params[:category].present?
      @search = Job.where("title LIKE ? AND industry_id = ? and status = ?", "%#{params[:search]}%","#{params[:category]}", 0)
      @search = @search.paginate(:page => params[:page], :per_page => 6).order(created_at: :desc)
    elsif params[:search].present? && !params[:category].present?
      @search = Job.where("title LIKE ? and status = ?", "%#{params[:search]}%", 0)
      @search = @search.paginate(:page => params[:page], :per_page => 6).order(created_at: :desc)
    elsif !params[:search].present? && params[:category].present?
      @search = Job.where("industry_id = ? and status = ?","#{params[:category]}", 0)
      @search = @search.paginate(:page => params[:page], :per_page => 6).order(created_at: :desc)
    elsif !params[:search].present? && params[:applied].present? and params[:applied] == 'true' and user_signed_in?
      @search = current_user.applied_jobs.paginate(:page => params[:page], :per_page => 6).order(created_at: :desc)
    elsif !params[:search].present? && params[:not_applied].present? and params[:not_applied] == 'true' and user_signed_in?
      @search = Job.where.not(id: current_user.job_applications.map(&:job_id)).paginate(:page => params[:page], :per_page => 6).order(created_at: :desc)  
    else
      @search = Job.where(status: 0).paginate(:page => params[:page], :per_page => 6).order(created_at: :desc)
    end
  end

  def search_candidate
   # user_ids =  UserJob.all.select{|j| (j.job_ids & current_user.jobs.map(&:id)).any?}.map(&:user_id).uniq
   # @users =  User.where("first_name LIKE ? AND role = ?","#{params[:search_candidate]}%", "candidate")
    if params[:salary_aearch].present?
      if  params[:salary_aearch] == "30000"
        a = "0"   
        obj = params[:salary_aearch].to_s
        
      elsif  params[:salary_aearch] == "60000"
        a = "0"   
        obj = params[:salary_aearch].to_s
      else
        a = "60000"
        obj = User.maximum(:salary_expectation)
      end
    else
      a = "0"
      obj = User.maximum(:salary_expectation)
    end

    if params[:search_candidate].present?
      @users =  User.where(role: 'candidate').where("lower(first_name) LIKE ? AND lower(salary_expectation) BETWEEN ? AND ?","#{params[:search_candidate].downcase}%", a, obj)

    elsif params[:location_search].present?
      @users =  User.where(role: 'candidate').where("lower(current_location) LIKE ? AND lower(salary_expectation) BETWEEN ? AND ?", "#{params[:location_search].downcase}%", a, obj)

    elsif  params[:salary_aearch].present?
      @users =  User.where(role: 'candidate').where("lower(salary_expectation) BETWEEN ? AND ?", a, obj)

    elsif params[:search_candidate].present? && params[:location_search].present? && params[:salary_aearch].present? 
      @users =  User.where("lower(first_name) LIKE ? AND role = ? AND lower(current_location) LIKE ? AND lower(salary_expectation) BETWEEN ? AND ?","#{params[:search_candidate].downcase}%", "candidate", "#{params[:location_search].downcase}%", a, obj)

    elsif params[:search_candidate].present? && params[:location_search].present?
      @users =  User.where("lower(first_name) LIKE ? AND role = ? AND lower(current_location) LIKE ?","#{params[:search_candidate].downcase}%", "candidate", "#{params[:location_search].downcase}%")

    elsif params[:location_search].present? && params[:salary_aearch].present? 
      @users =  User.where(role: 'candidate').where("lower(current_location) LIKE ? AND lower(salary_expectation) BETWEEN ? AND ?", "#{params[:location_search].downcase}%", a, obj)


    elsif params[:search_candidate].present? && params[:salary_aearch].present? 
      @users =  User.where("lower(first_name) LIKE ? AND role = ? AND lower(salary_expectation) BETWEEN ? AND ?","#{params[:search_candidate].downcase}%", "candidate", a, obj)
    else
      @users = User.where(role: 'candidate')
    end
  end

  def about
  end

  def contact
  end

  def platform
  end

  def privacy
  end

  def term_condition
  end

end


# "salary_expectation BETWEEN ? AND ?", 0.to_s, 30000.to_s