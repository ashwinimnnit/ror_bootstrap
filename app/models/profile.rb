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
class Profile < ActiveRecord::Base
  extend Utils::OauthImage
  belongs_to :user
  def self.user_fb_image(user)
    info = UserAuthentication
           .where("authentication_provider_id= 1 and user_id= ?", user.id)
           .first
    if info
      uri = "https://graph.facebook.com/v2.5/#{info.uid}/picture?type=large&redirect=false"
      facebook_api(uri, user)
      user.update_attribute(:avatar_file_name, "img.jpg")
      user
    else
      {
        message: "User need to be logged-in via fabebook"
      }
    end
  end
end
