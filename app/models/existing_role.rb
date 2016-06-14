class ExistingRole < ActiveRecord::Base
  validates :name, presence: true
  def self.update_resource(param)
    id = param[:id]
    name = param[:name]
    role = where("id = ?", id).first
    if role
      role.update_attribute("name", name)
      response = {
        status: 200,
        message: "Updated successfully"
      }
    else
      response = {
        status: 404,
        message: "Record not found for updation"
      }
    end
    response
  end

  def self.display_roles
    existing_role = {}
    available_roles = ExistingRole.all
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
