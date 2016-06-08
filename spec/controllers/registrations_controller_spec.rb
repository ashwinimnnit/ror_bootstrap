require "spec_helper"
describe RegistrationsController do
  before do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    sign_out :user
  end
  describe "GET #new" do
    it "responds successfully with an HTTP 200 status code" do
      get :new
      expect(response).to have_http_status(200)
    end
  end

  describe "#check_email_availability" do
    let(:existing_user) { create(:user) }
    let(:new_user) { build(:user) }
    let(:available) { JSON.parse(response.body)["available"] }

    it "checks existing emails correctly" do
      post :check_email_availability, email: existing_user.email, format: :json
      expect(available).to be(false)
    end

    it "checks new emails correctly" do
      post :check_email_availability, email: new_user.email, format: :json
      expect(available).to be(true)
    end
  end
end
