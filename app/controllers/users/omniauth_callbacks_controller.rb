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
module Users
  # for user authentication
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    def facebook
      create
    end

    def google_oauth2
      create
    end

    private

    def create
      auth_params = request.env['omniauth.auth']
      provider = AuthenticationProvider.where(name: auth_params.provider).first
      authentication = provider.user_authentications
                               .where(uid: auth_params.uid).first
      existing_user = current_user ||
                      User.where('email = ?', auth_params['info']['email'])
                          .first

      if authentication
        sign_in_with_existing_authentication(authentication)
      elsif existing_user
        create_authentication_and_sign_in(auth_params, existing_user, provider)
      else
        create_user_and_authentication_and_sign_in(auth_params, provider)
      end
    end

    def sign_in_with_existing_authentication(authentication)
      sign_in_and_redirect(:user, authentication.user)
    end

    def create_authentication_and_sign_in(auth_params, user, provider)
      UserAuthentication.create_from_omniauth(auth_params, user, provider)

      sign_in_and_redirect(:user, user)
    end

    def create_user_and_authentication_and_sign_in(auth_params, provider)
      user = User.create_from_omniauth(auth_params)
      if user.valid?
        create_authentication_and_sign_in(auth_params, user, provider)
      else
        flash[:error] = user.errors.full_messages.first
        redirect_to new_user_registration_url
      end
    end
  end
end
