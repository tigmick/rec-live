Rails.application.config.middleware.use OmniAuth::Builder do
  provider :linkedin, "8642gnnpev2g2s", "pzYpFLn1x9f71RJ0", :scope => 'r_basicprofile r_emailaddress', :fields => ["id", "email-address", "first-name", "last-name", "headline", "industry", "picture-url", "public-profile-url", "location", "connections","summary", "specialties","positions", "educations"]
end