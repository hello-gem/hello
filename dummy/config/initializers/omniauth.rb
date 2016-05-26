ENV['FACEBOOK_KEY']    ||= '1715712485365376'
ENV['FACEBOOK_SECRET'] ||= 'df1c7948c0c63833bc55f7864616600c'




Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['FACEBOOK_KEY'], ENV['FACEBOOK_SECRET']
end
