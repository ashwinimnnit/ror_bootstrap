require "rails_helper"
RSpec.describe ProfilesController, type: :controller do
  before(:each, user_sign_in: true) do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    @created_user = create(:user)
    sign_in @created_user
  end

  describe "GET #new in logut mode" do
    it "responds successfully with an HTTP 302 status code" do
      get :index
      expect(response).to have_http_status(302)
    end
  end

  describe "GET #new in loged in mode", user_sign_in: true do
    let(:expected_template) { get :index }
    it "render successfully the templates" do
      expect(expected_template).to render_template("profiles/index")
    end
  end

  describe "Update User Image", user_sign_in: true do
    let(:expected_response) { JSON.parse(response.body) }
    it "returns true If image uploaded successfully" do
      post :update_profile_image, user: {
        attr: @created_user.id,
        avatar: Rack::Test::UploadedFile
          .new(Rails.root.join("spec/files/images/test_image.png"), "image/png")
      }
      expect(expected_response["flag"]).to be(true)
    end
  end
end
