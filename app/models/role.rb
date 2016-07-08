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
    roles_to_added = param["roles"].map(&:to_i)
    param["users"].map(&:to_i).each do |uid|
      user = User.find_by_id(uid)
      next unless user
      roles_to_added.each do |new_role|
        user.roles << Role.create(user_id: user.id, user_role: new_role)
      end
    end
  end
end
