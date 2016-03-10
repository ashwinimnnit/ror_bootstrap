class Role < ActiveRecord::Base 
 belongs_to :user

  validates :user_id, uniqueness: {scope: :userole} 
  def self.assignment_roles (user,roles)
   roles.each do |r|
    user.roles.create(:userole => r)
   end
  end

  def self.bulk_assignment_roles ( data )
       data['admin_rol'].each do |user|
          data['user']['roles'].each do |rol|
           @role = Role.new(:user_id => user, :userole => rol)
          begin
	    @role.save!
	    rescue =>  @e
	 end           
       end
    end
  return @role ,@e
  end
  
  end 



