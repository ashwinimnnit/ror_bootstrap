require "rails_helper"
RSpec.describe Profile, type: :model do
  it "browse user's image from facebook" do
    user = User.find_by_email("ashwinidx@gmail.com")
    response = Profile.user_fb_image user
    expect(response).to be_instance_of(User)
  end

  it "Retuns message user need to be logged-in via fb" do
    user = User.find_by_email("diksha@gmail.com")
    response = Profile.user_fb_image user
    expect(response[:message]).to eq("User need to be logged-in via fabebook")
  end
end
