module ApplicationHelper
 
 def get_roles_name ( s= [])
  arr = ''
  s.each do |sid|
    CONFIG.values.each do |i|
     if i["id"].to_i == sid  
      arr += "<div> #{i['name']} </div>"
     end
   end
  end
 arr.html_safe 
 end

end
