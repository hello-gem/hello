# Read about factories at https://github.com/thoughtbot/factory_girl
# https://github.com/thoughtbot/factory_girl/blob/master/GETTING_STARTED.md

# https://github.com/stympy/faker#usage

FactoryGirl.define do


  factory :user do
    name { Faker::Name.name }
    city { Faker::Address.city  } # for dummy's customized sign up
  end

  factory :credential do
    user

    factory :classic_credential do
      strategy Credential._classic
      email    { Faker::Internet.email }
      username { Faker::Internet.user_name.parameterize }
      password '1234'
    end
  end



end
