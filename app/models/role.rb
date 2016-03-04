class Role < ActiveRecord::Base 
 belongs_to :user

  def self.assignment_roles (user,roles)
   roles.each do |r|
    user.roles.create(:userole => r)
   end
  end


end
