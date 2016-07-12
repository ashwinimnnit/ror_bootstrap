require "rails_helper"
RSpec.describe Role, type: :model do
  it "creates roles for users" do
    user = User.find_by_email("ashwinidx@gmail.com")
    MemberRole.role_assignment("users" => [user.id], "roles" => [16, 17])
    expect(user.reload.roles.count).to eq(2)
  end
end
