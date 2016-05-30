# Talentica - bootstrap project
# Copyright   Ashwini Kumar
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
class RegistrationsController < Devise::RegistrationsController
  before_filter :authenticate_user!

  def email_found
    {
      available:   false,
      message: "The Email id is already registered",
      notice_class: "email_not_available"
    }
  end

  def email_not_found
    {
      available: true,
      message: "The Email id is available to use",
      notice_class: "email_available"
    }
  end

  def check_email_availabilty
    sleep 5
    @user = User.has_email_as params["email"]
    @response = @user.present? ? email_found : email_not_found
    respond_to do |format|
      format.json { render json: @response }
    end
  end

  protected

  def update_resource(resource, params)
    if verify_new_password?(params) && resource.valid_password?(params["password"])
      resource.update_attributes(password: params["new_password"])
    end
    update_user_details(params, resource) if params["password"].empty?
  end

  def verify_new_password?(param)
    param["new_password"] == param["confirm_password"]
  end

  def update_user_details(param, resource)
    resource.update_attributes(firstname: param["firstname"],
                               lastname: param["lastname"]
                              )
  end

  private

  # override sign_up_params method
  def sign_up_params
    params.require(:user).permit(:firstname, :lastname,
                                 :email, :password,
                                 :password_confirmation,
                                 :avatar, :user_name)
  end

  # override sign_up_params method
  def account_update_params
    params.require(:user).permit(:firstname, :lastname,
                                 :email, :password,
                                 :password_confirmation, :current_password,
                                 :new_password, :confirm_password)
  end
end
