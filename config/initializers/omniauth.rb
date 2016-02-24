Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, "667565615987-2g5cgj55cdnt61skmsvd7s03j36aki0p.apps.googleusercontent.com", "yIx22BetfaDQpez26IsyYcuh"
   {
      :name => "google",
      :scope => "email, profile, plus.me, http://gdata.youtube.com",
      :prompt => "select_account",
      :image_aspect_ratio => "square",
      :image_size => 50
    }

  #provider :facebook, '1696345830581755', 'a4e7450a2fe4b948629fcf28b71056f5'
end
