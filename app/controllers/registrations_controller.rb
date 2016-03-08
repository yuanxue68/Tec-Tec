class RegistrationsController < Devise::RegistrationsController

  private
  
  def sign_up_params
    params.require(:user).permit(:email, :password, :password_confirmation, :display_name, :picture)
  end

  def account_update_params
    params.require(:user).permit(:email, :password, :password_confirmation, :display_name, :picture, :current_password)
  end
end
