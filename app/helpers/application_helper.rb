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
module ApplicationHelper
  def get_roles_name(s = [])
    arr = ""
    s.each do |sid|
      CONFIG.values.each do |i|
        arr += "<div> #{i['name']} </div>" if i["id"].to_i == sid
      end
    end
    arr.html_safe
  end

  def broadcast(channel, &block)
    message = { channel: channel, data: capture(&block) }
    uri = URI.parse("http://localhost:9292/faye")
    Net::HTTP.post_form(uri, message: message.to_json)
  end

  def users
    User.all.to_a
  end
end
