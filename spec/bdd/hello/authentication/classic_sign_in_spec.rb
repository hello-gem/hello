require 'spec_helper'

RSpec.bdd.capability 'I can Sign In With Email' do

  role 'User' do

    before do
      given_I_have_an_email_credential
      expect(Access.count).to eq(0)
    end

    context 'Components', type: :feature do

      uic 'Dual Form' do

        scenario 'Empty Form' do
          When 'I sign in with an empty form' do
            visit hello.root_path
            click_button 'Sign In'
          end

          Then 'I should see an error message' do
            expect_to_see 'found while trying to sign in'
          end

          Then 'and be on the sign in page' do
            expect(current_path).to eq hello.sign_in_path
          end
        end # scenario

      end # uic

      uic 'Single Form' do

        context 'General' do

          Given 'I am on the sign in page' do
            visit '/hello/sign_in'
          end

          story 'Valid Scearios' do

            scenario 'Valid Email & Password' do
              When 'I sign in with a valid form' do
                fill_in_login_form('foo@bar.com')
                click_button 'Sign In'
              end
            end # scenario

            scenario 'Valid Username & Password' do
              When 'I sign in with a valid form' do
                fill_in_login_form('foobar')
                click_button 'Sign In'
              end
            end # scenario

            Then 'I should see a confirmation message' do
              expect_flash_notice 'You have signed in successfully'
            end

            Then 'I should be on the home page' do
              expect_to_be_on '/'
            end

            Then 'Database now has 1 Access' do
              expect(Access.count).to eq(1)
            end

          end # story

          story 'Invalid Scearios' do

            scenario 'Empty Form' do
              When 'I sign in with an empty form' do
                click_button 'Sign In'
              end
            end # scenario

            scenario 'Email not found' do
              When 'I sign in with an empty form' do
                click_button 'Sign In'
              end
            end # scenario

            scenario 'Username not found' do
              When 'I sign in with a bad username' do
                fill_in_login_form('foobar9999')
                click_button 'Sign In'
              end
            end # scenario

            scenario 'Wrong Password' do
              When 'I sign in with a bad password' do
                fill_in_login_form('foobar', '9999')
                click_button 'Sign In'
              end
            end # scenario

            scenario 'Blank Password' do
              When 'I sign in with a bad password' do
                fill_in_login_form('foobar', '')
                click_button 'Sign In'
              end
            end # scenario

            Then 'I should see a confirmation message' do
              expect_to_see 'found while trying to sign in'
            end

            Then 'I should be on the sign in page' do
              expect_to_be_on '/hello/sign_in'
            end

            Then 'Database still has 0 Access' do
              expect(Access.count).to eq(0)
            end
          end # story

        end # context

        context 'Extras' do

          story 'Previous URL' do

            scenario 'Has Previous URL' do

              Given 'I visited a page that required me to authenticate' do
                visit '/onboarding'
                expect_to_be_on '/hello/sign_in'
              end

              When 'I sign in with a valid form' do
                fill_in_login_form('foo@bar.com')
                click_button 'Sign In'
                expect_flash_notice 'You have signed in successfully'
              end

              Then 'I should be on the home page' do
                expect_to_be_on '/'
              end

            end # scenario

            scenario 'No Previous URL' do

              Given 'I am on the sign in page' do
                visit '/hello/sign_in'
              end

              When 'I sign in with a valid form' do
                fill_in_login_form('foo@bar.com')
                click_button 'Sign In'
                expect_flash_notice 'You have signed in successfully'
              end

              Then 'I should be on the home page' do
                expect_to_be_on '/'
              end

            end # scenario

          end # story

          story 'Keep me' do

            Given 'I am on the sign in page' do
              visit '/hello/sign_in'
            end

            scenario 'Checked' do

              Given 'I check "keep me"' do
                check 'keep_me'
              end

              When 'I sign in with a valid form' do
                fill_in_login_form('foo@bar.com')
                click_button 'Sign In'
                expect_flash_notice 'You have signed in successfully'
              end

              Then 'and be signed in for 30 days' do
                expect(Access.last.expires_at).to be > 29.days.from_now
              end

            end # scenario

            scenario 'Unchecked' do

              Given 'I do not check "keep me"' do
                # left blank
              end

              When 'I sign in with a valid form' do
                fill_in_login_form('foo@bar.com')
                click_button 'Sign In'
                expect_flash_notice 'You have signed in successfully'
              end

              Then 'and be signed in for 30 minutes' do
                a = Access.last
                expect(a.expires_at).to be < 31.minutes.from_now
                expect(a.expires_at).to be > 29.minutes.from_now
              end

            end # scenario

          end # story

        end # context

      end # uic

    end # context

    api 'API', type: :request do

      scenario 'Valid Parameters' do
        When 'I sign in with valid parameters' do
          post '/hello/sign_in.json', sign_in: {login: 'foo@bar.com', password: '1234'}
        end

        Then 'I should see the access object' do
          expect(json_response.keys).to match_array ['expires_at', 'token', 'user', 'user_id']
          expect(json_response['user'].keys).to match_array ['id', 'accesses_count', 'city', 'created_at', 'credentials_count', 'locale', 'name', 'role', 'time_zone', 'updated_at', 'username']
        end

        Then 'I should get a 201 response' do
          expect(response.status).to         eq(201)
          expect(response.status_message).to eq('Created')
        end

        Then 'Database now has 1 Access' do
          expect(Access.count).to eq(1)
        end
      end # scenario

      scenario 'Blank Parameters' do
        When 'I sign in with an empty parameters' do
          post '/hello/sign_in.json', sign_in: {login: ''}
        end

        Then 'I should see errors' do
          expect(json_response).to eq({
            "login"=>["can't be blank"],
            "password"=>["can't be blank"]
          })
        end

        Then 'I should get a 422 response' do
          expect(response.status).to         eq(422)
          expect(response.status_message).to eq('Unprocessable Entity')
        end

        Then 'Database now has 0 Access' do
          expect(Access.count).to eq(0)
        end
      end # scenario

    end # api

  end # role

end # capability
