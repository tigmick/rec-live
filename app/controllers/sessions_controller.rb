class SessionsController < Devise::SessionsController

  def create
    resource = User.find_for_database_authentication(email: params[:user][:email])
    return invalid_login_attempt unless resource

    if resource.valid_password?(params[:user][:password])
      sign_in :user, resource
      return render json: { location: after_sign_in_path_for(resource) }
    end

    invalid_login_attempt
  end

  protected

  def invalid_login_attempt
    # set_flash_message(:alert, :invalid)
    render json: 'Invalid email or password.', status: 401
  end
end