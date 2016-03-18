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
  # registration of new user by overriding native devise
  private

  # override sign_up_params method
  def sign_up_params
    params.require(:user).permit(:firstname, :lastname,
                                 :email, :password,
                                 :password_confirmation)
  end

  # override sign_up_params method
  def account_update_params
    params.require(:user).permit(:firstname, :lastname,
                                 :email, :password,
                                 :password_confirmation, :current_password)
  end
end
