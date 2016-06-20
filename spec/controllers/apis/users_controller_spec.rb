require "spec_helper"
describe Apis::UsersController do
  before(:each, user_sign_in: true) do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    @created_user = create(:user)
    sign_in @created_user
  end

  describe "Create users" do
    let(:created_user) { JSON.parse(response.body) }
    it "Creates a users via api controller" do
      post :create_users, attributes_for(:user)
      expect(created_user["message"]["id"]).should_not eq(nil)
      expect(created_user["errors"])
    end
  end
end
