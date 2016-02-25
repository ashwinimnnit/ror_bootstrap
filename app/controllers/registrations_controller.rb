class RegistrationsController < Devise::RegistrationsController

 private

 #override sign_up_params method to add firstname and lastname during signup
  def sign_up_params
    params.require(:user).permit(:firstname, :lastname, :email, :password, :password_confirmation)
  end

 #override sign_up_params method to add firstname and lastname during user edit profile
  def account_update_params
    params.require(:user).permit(:firstname, :lastname, :email, :password, :password_confirmation, :current_password)
  end


  

end
