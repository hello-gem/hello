# Read about factories at https://github.com/thoughtbot/factory_girl
# https://github.com/thoughtbot/factory_girl/blob/master/GETTING_STARTED.md

# https://github.com/stympy/faker#usage

FactoryGirl.define do


  factory :user do
    name { Faker::Name.name }
    city { Faker::Address.city  } # for dummy's customized sign up
    locale 'en'
    time_zone Time.zone.name
    role 'user'

    username { Faker::Internet.user_name(name, %w(-_)) }
    password '1234'

    factory :admin_user do
      name 'Admin'
      role 'admin'
      username 'admin'
      password 'admin'
    end
  end

  factory :credential do
    user

    factory :classic_credential do
      strategy Credential._classic
      email    { Faker::Internet.email }
    end
  end

  factory :access_token do
    user
    user_agent_string "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/34.0.1847.131 Safari/537.36"
  end



end
