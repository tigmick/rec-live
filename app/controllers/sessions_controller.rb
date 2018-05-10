class SessionsController < Devise::SessionsController

  def create
    resource = User.find_for_database_authentication(email: params[:user][:email])
    return invalid_login_attempt unless resource

    if resource.valid_password?(params[:user][:password])
      if resource.role == "client"
        unless resource.verify_candidate
          set_flash_message! :notice, :inactive
          return render json: { location: root_path } 
        else  
          sign_in :user, resource
          return render json: { location: after_sign_in_path_for(resource) }
        end
      else
        sign_in :user, resource
        return render json: { location: after_sign_in_path_for(resource) }
      end
    end

    invalid_login_attempt
  end

  protected

  def invalid_login_attempt
    # set_flash_message(:alert, :invalid)
    render json: 'Invalid email or password.', status: 401
  end
end