# https://docs.bugsnag.com/platforms/ruby/rails/configuration-options/
Bugsnag.configure do |config|
  if true | Rails.env.in?(['production', 'staging'])
    config.api_key = ENV['BUGSNAG_API_KEY']
  end
end
