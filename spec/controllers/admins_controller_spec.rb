require "rails_helper"
RSpec.describe AdminsController, type: :controller do
  # hook called in logout mode
  before(:each, specific_specs: true) do
    @request.env["devise.mapping"] = Devise.mappings[:user]
  end

  # hook called for admin user to get signed in
  before(:each, admin_activity: true) do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    @created_admin = create(:admin)
    sign_in @created_admin
  end

  # hook called for non-admin user to get signed in
  before(:each, user_activity: true) do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    @created_user = create(:user)
    sign_in @created_user
  end

  describe "GET #new in logut mode" do
    it "responds successfully with an HTTP 302 status code" do
      get :new
      expect(response).to have_http_status(302)
    end
  end

  describe "GET #index in login mode non admin user", user_activity: true do
    let(:expected_response) { JSON.parse(response.body)["status"] }
    it "responds successfully with an HTTP 401 status code", specific_specs: true do
      get :index
      expect(expected_response).to be(401)
    end
  end

  describe "GET #index in login mode admin user", admin_activity: true do
    let(:expected_template) { get :index }
    it "admin page should render", specific_specs: true do
      # TODO: _role.html to be written in view spec
      expect(expected_template).to render_template("admins/index")
      expect(expected_template).to render_template("layouts/application")
    end
  end

  describe "Admin can add a memeber", admin_activity: true do
    it "Creates user from admin", specific_specs: true do
      post :add_members, user: attributes_for(:user)
      expect(flash[:success]).to be_present
      expect(response).to have_http_status(200)
    end
  end

  describe "Non-admin creates a user", user_activity: true do
    let(:expected_response) { JSON.parse(response.body)["status"] }
    it "Creates user from non-admin", specific_specs: true do
      post :add_members, user: attributes_for(:foo)
      expect(expected_response).to be(401)
    end
  end
end
