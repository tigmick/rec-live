Rails.application.config.middleware.use OmniAuth::Builder do
  provider :linkedin, "75apdvhpnh7aev", "ZWrZl92D0XXxGBVS", :scope => 'r_basicprofile r_emailaddress', :fields => ["id", "email-address", "first-name", "last-name", "headline", "industry", "picture-url", "public-profile-url", "location", "connections","summary", "specialties","positions", "educations"]
end