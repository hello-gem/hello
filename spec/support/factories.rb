# Read about factories at https://github.com/thoughtbot/factory_girl
# https://github.com/thoughtbot/factory_girl/blob/master/GETTING_STARTED.md

# https://github.com/stympy/faker#usage

FactoryGirl.define do

  factory :user do
    name { Faker::Name.name }
    locale 'en'
    time_zone Time.zone.name
    role 'user'
    username { Faker::Internet.user_name(name, %w(-_)) }
    email { "#{username}@provider.com" }
    password '1234'

    trait :without_credentials do
      email nil
      password nil
    end

    factory :user_webmaster do
      name 'Webmaster'
      role 'webmaster'
    end

    factory :user_onboarding do
      name 'Onboarding'
      role 'onboarding'
    end

    factory :user_user do
      name 'User'
      role 'user'
    end
  end

  factory :email_credential do
    user
    email { Faker::Internet.email }
  end

  factory :password_credential do
    user
    after(:build) { |pc| pc.password = '1234' }
  end

  factory :access do
    user
    expires_at nil
    user_agent_string 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/34.0.1847.131 Safari/537.36'
    factory :valid_access do
      expires_at { 30.minutes.from_now }
    end
  end
end
