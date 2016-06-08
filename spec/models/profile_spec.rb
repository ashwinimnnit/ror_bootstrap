require "rails_helper"
RSpec.describe Profile, type: :model do
  it "deals with facebook-user profile image" do
    user = User.find_by_email("ashwinidx@gmail.com")
    response = Profile.user_fb_image user
    expect(response).to be_instance_of(User)
  end

  it "deals with non-facebook user profile image" do
    user = User.find_by_email("ashwiniddddxxxx@f.cm")
    response = Profile.user_fb_image user
    expect(response[:message]).to eq("User need to be logged-in via fabebook")
  end
end
