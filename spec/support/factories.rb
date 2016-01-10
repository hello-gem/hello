# Read about factories at https://github.com/thoughtbot/factory_girl
# https://github.com/thoughtbot/factory_girl/blob/webmaster/GETTING_STARTED.md

# https://github.com/stympy/faker#usage

FactoryGirl.define do
  factory :user do
    name { Faker::Name.name }
    city { Faker::Address.city } # for dummy's customized sign up
    locale 'en'
    time_zone Time.zone.name
    role 'user'

    username { Faker::Internet.user_name(name, %w(-_)) }

    # TODO: improve this
    after(:build)  { |user| build(:password_credential,  user: user) }
    after(:create) { |user| create(:password_credential, user: user) }

    factory :webmaster_user do
      name 'Admin'
      role 'webmaster'
      username 'webmaster'
      factory :user_webmaster do
        name 'Webmaster'
      end
    end

    factory :user_onboarding do
      name 'Onboarding'
      role 'onboarding'
      username 'onboarding'
    end

    factory :user_user do
      name 'User'
      role 'user'
      username 'user'
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
