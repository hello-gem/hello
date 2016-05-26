require 'spec_helper'

describe Credential do
  example 'Validations' do
    expect(subject.valid?).to eq(true)
    expect(subject.errors.messages).to eq({})
  end

  example 'Saving Validations' do
    expect(subject.save).to eq(nil)
    expect(subject.errors.messages).to eq({:user => ["can't be blank"]})
    subject.valid?
    expect(subject.errors.messages).to eq(user: ["can't be blank"],
                                          # type: ['is not included in the list']
                                          )
  end
end

describe FacebookCredential do
  example 'Validations' do
    subject.valid?
    expect(subject.errors.messages).to eq(user: ["can't be blank"],
                                          uid: ["can't be blank"],
                                          email: ["can't be blank"])



    # email uniqueness

    # A

    expect {
      EmailCredential.create!(user: create(:user), email: "foo@bar.com")
    }.not_to raise_error(ActiveRecord::RecordInvalid)

    expect {
      EmailCredential.create!(user: create(:user), email: "foo@bar.com")
    }.to raise_error(ActiveRecord::RecordInvalid)

    # B

    expect {
      EmailCredential.create!(user: create(:user), email: "foo2@bar.com")
    }.not_to raise_error(ActiveRecord::RecordInvalid)

    expect {
      FacebookCredential.create!(user: create(:user), email: "foo2@bar.com", uid: 12345)
    }.not_to raise_error(ActiveRecord::RecordInvalid)

    # C

    expect {
      FacebookCredential.create!(user: create(:user), email: "foo2@bar.com", uid: 123456)
    }.not_to raise_error(ActiveRecord::RecordInvalid)

    expect {
      FacebookCredential.create!(user: create(:user), email: "foo2@bar.com", uid: 1234567)
    }.not_to raise_error(ActiveRecord::RecordInvalid)

  end
end



  # def set_omniauth(opts = {})
  #   default = {:provider => :facebook,
  #              :uuid     => "1234",
  #              :facebook => {
  #                             :email => "foobar@example.com",
  #                             :gender => "Male",
  #                             :first_name => "foo",
  #                             :last_name => "bar"
  #                           }
  #             }

  #   credentials = default.merge(opts)
  #   provider = credentials[:provider]
  #   user_hash = credentials[provider]

  #   OmniAuth.config.test_mode = true

  #   OmniAuth.config.mock_auth[provider] = {
  #     'uid' => credentials[:uuid],
  #     "extra" => {
  #     "user_hash" => {
  #       "email" => user_hash[:email],
  #       "first_name" => user_hash[:first_name],
  #       "last_name" => user_hash[:last_name],
  #       "gender" => user_hash[:gender]
  #       }
  #     }
  #   }
  # end

  # def set_invalid_omniauth(opts = {})

  #   credentials = { :provider => :facebook,
  #                   :invalid  => :invalid_crendentials
  #                  }.merge(opts)

  #   OmniAuth.config.test_mode = true
  #   OmniAuth.config.mock_auth[credentials[:provider]] = credentials[:invalid]

  # end

  # before(:each) do
  #   set_omniauth
  # end






describe Oauth2Controller::FacebookBusiness do

  let(:subject) { described_class.new(@current_user, 12345, "foo@example.com") }

  describe "public methods" do

    describe ".sign_up!(hash)" do

      example "with valid values" do
        # Given "a valid hash" do
        # end
        # When "I call sign_up" do
        # end
        hash = {info: {name: "Name"}}

        expect {
        expect {
          subject.sign_up!(hash)
        }.to change { User.count }.from(0).to(1)
        }.to change { Credential.count }.from(0).to(2)


      end

    end


    describe ".magic" do

      describe "1. signed in" do
        Given "I am currently signed in" do
          @current_user = create(:user)
        end
        describe "1.1. uid found" do
          example "1.1.1. uid found linked to MY user" do
            Given "and this Facebook was previously linked to my user" do
              @credential = FacebookCredential.create(user: @current_user, uid: 12345, email: "foo@example.com")
            end

            When "I get the Facebook callback" do
              subject
            end

            Then "entity.magic should return true" do
              expect(subject.magic).to eq(true)
            end

            And "entity.status should return :nothing" do
              expect(subject.status).to eq(:nothing)
            end
          end
          example "1.1.2. uid found linked to OTHER user" do
            Given "but this Facebook was previously linked to other user" do
              @credential = FacebookCredential.create(user: create(:user), uid: 12345, email: "whatever")
            end

            When "I get the Facebook callback" do
              subject
            end

            Then "entity.magic should return false" do
              expect(subject.magic).to eq(false)
            end

            And "entity.status should return :uid_found" do
              expect(subject.status).to eq(:uid_found)
            end

            And "entity.errors should have a message" do
              expect(subject.errors.messages).to eq(1)
            end
          end
        end

        example "1.2. uid not found" do
          Given "and this Facebook was NOT previously linked to any user" do
          end

          When "I get the Facebook callback" do
            subject
          end

          Then "entity.magic should return true" do
            expect(subject.magic).to eq(true)
          end

          And "entity.status should return :linked" do
            expect(subject.status).to eq(:linked)
          end

          And "entity.facebook_credential should be linked to my user" do
            expect(subject.facebook_credential.user).to eq(@current_user)
          end
        end
      end
      describe "2. not signed in" do
        Given "I am NOT currently signed in" do
          #
        end

        example "2.1. uid found" do
          Given "and this Facebook was previously linked to a user" do
            @credential = FacebookCredential.create(user: create(:user), uid: 12345, email: "whatever")
          end

          When "I get the Facebook callback" do
            subject
          end

          Then "entity.magic should return true" do
            expect(subject.magic).to eq(true)
          end

          And "entity.status should return :sign_in" do
            expect(subject.status).to eq(:sign_in)
          end
        end

        describe "2.2. uid not found" do
          Given "but this Facebook was NOT previously linked to a user" do
            #
          end

          example "2.2.1. email found" do
            Given "and this Email was previously linked to a user" do
              create(:email_credential, email: "foo@example.com", user: create(:user))
            end

            When "I get the Facebook callback" do
              subject
            end

            Then "entity.magic should return false" do
              expect(subject.magic).to eq(false)
            end

            And "entity.status should return :email_found" do
              expect(subject.status).to eq(:email_found)
            end

            And "entity.errors should have a message" do
              expect(subject.errors.messages).to eq(1)
            end
          end

          example "2.2.2. email not found" do
            Given "but this Email was NOT previously linked to a user" do
              #
            end

            When "I get the Facebook callback" do
              subject
            end

            Then "entity.magic should return true" do
              expect(subject.magic).to eq(true)
            end

            And "entity.status should return :sign_up" do
              expect(subject.status).to eq(:sign_up)
            end
          end
        end
      end
    end
  end
end
