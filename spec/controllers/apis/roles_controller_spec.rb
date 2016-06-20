require "spec_helper"
describe Apis::RolesController do
  before(:each, user_sign_in: true) do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    @created_user = create(:user)
    sign_in @created_user
  end

  before(:each, create_role: true) do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    @created_user = create(:user)
    sign_in @created_user
    @created_role = create(:user_role)
  end

  describe "Create roles", user_sign_in: true do
    let(:created_role) { JSON.parse(response.body) }
    it "Creates a users via api controller" do
      post :add_roles, attributes_for(:user_role)
      expect(created_role["status"]).to be(200)
    end
  end

  describe "Display roles", create_role: true do
    let(:roles) { JSON.parse(response.body) }
    it "Display available roles" do
      get :index
      expect(roles["status"]).to be(200)
    end
  end

  describe "Display no roles" do
    let(:roles) { JSON.parse(response.body) }
    it "Rerurns 404 when roles are not  in db" do
      get :index
      expect(roles["status"]).to be(404)
    end
  end

  describe "Update roles", create_role: true do
    let(:updated_role) { JSON.parse(response.body) }
    it "Updates a role via api controller" do
      post :update, id: @created_role.id, name: "new_role"
      expect(updated_role["response"]["name"]).to eq("new_role")
    end
  end
end
