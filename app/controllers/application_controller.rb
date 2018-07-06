class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :configure_permitted_parameters, if: :devise_controller?
  before_filter :default_url


  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) {|u| u.permit(:email, :password, :password_confirmation, :role,:first_name,:last_name,:contact_no,:job_title,:company_name, :current_location, :salary_expectation, :image)}
    devise_parameter_sanitizer.permit(:account_update) {|u| u.permit(:email, :password, :password_confirmation, :role, :salary_expectation,:current_location,:first_name,:last_name,:contact_no,:current_password, :image)}
  end

  def default_url
    ActionMailer::Base.default_url_options = {:host => request.host_with_port}
  end

  protected
  def after_sign_in_path_for(resource)
    if resource.email == "tigmicheal@yahoo.co.uk"
      admin_dashboard_path
    elsif resource.class.name == "AdminUser"
      admin_dashboard_path
      # elsif resource.candidate?
      #   resource.sign_in_count < 2 ? edit_user_registration_path : users_dashboard_path
    else
      users_dashboard_path
    end
  end
end
