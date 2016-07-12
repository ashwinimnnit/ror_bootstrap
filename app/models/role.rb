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
class Role < ActiveRecord::Base
  has_many :member_role
  has_many :user, through: :member_role
  has_many :posts
  validates :name, presence: true

  def self.update_resource(param)
    id = param[:id]
    name = param[:name]
    role = where("id = ?", id).first
    role.update_attribute("name", name) if role
    role
  end

  def self.display_roles
    existing_role = {}
    available_roles = Role.all
    index = 0
    available_roles.each do |res|
      temp = {}
      temp["id"] = res.id
      temp["name"] = res.name
      existing_role[index += 1] = temp
    end
    existing_role
  end
end
