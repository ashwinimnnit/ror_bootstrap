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
  belongs_to :user
  has_many :posts
  validates :user_id, uniqueness: { scope: :user_role }

  def self.assignment_roles(user, roles)
    roles.each do |r|
      user.roles.create(user_role: r)
    end
  end

  def self.bulk_assignment_roles(param)
    roles_to_added = param['user']['roles'].map(&:to_i)
    param['users'].each do |id|
      user = User.find(id)
      user_roles = user.roles.select('user_role').map(&:user_role)
      user_roles_to_add = roles_to_added - user_roles
      user_roles_to_add.each do |user_role|
        Role.create!(user_id: id, user_role: user_role)
      end
    end
  end

  #    data['admin_rol'].each do |user|
  #      data['user']['roles'].each do |rol|
  #        @role = Role.new(user_id: user, userole: rol)
  #        begin
  #          @role.save!
  #        rescue => @e
  #        end
  #      end
  #    end
  #    return @role, @e
  #  end
end
