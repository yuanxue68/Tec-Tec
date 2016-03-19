class RegistrationsController < Devise::RegistrationsController
  
  def update_resource(resource, params)
    resource.update_without_password(params)
  end

  private
  
  def sign_up_params
    params.require(:user).permit(:email, :password, :password_confirmation, :display_name, :picture)
  end

  def account_update_params
    params.require(:user).permit(:email, :password, :password_confirmation, :display_name, :picture)
  end

  def after_update_path_for(resource)
    user_path(resource)
  end
end
