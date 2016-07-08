class UserRole < ActiveRecord::Base
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
    available_roles = UserRole.all
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
