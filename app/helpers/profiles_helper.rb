module ProfilesHelper

 def display_roles (user)
  s = []
  user.roles.each do |r|
  s << r['userole']
  end
 get_roles_name s 
 end




end
