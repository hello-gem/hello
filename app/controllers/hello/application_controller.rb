class Hello::ApplicationController < ApplicationController
  include BeforeActions::Controller

  # authorization intentionally simple
  # this code is expected to be rewritten after more core features are developed
  # accepting PR :)
  before_action do
    either = 0
    guest  = 1
    user   = 2

    guest_homepage = hello.root_path
    user_homepage  = hello.user_path

    autho_data = {
      welcome:  {
        index:    guest,
        sign_out: either
      },
      registration: {
        #
        sign_up:          guest,
        create:           guest,
        sign_up_welcome:  either,
        #
        sign_in:          guest,
        authenticate:     guest,
        sign_in_welcome:  user,
        #
        forgot:           guest,
        ask:              guest,
        forgot_welcome:   guest,
        #
        reset_token:      guest,
        reset:            guest,
        save:             guest,
      },
      user:       user,
      credentials: user,
      sessions: user,
    }

    autho_c = autho_data[controller_name.to_sym]
    must_be_a = autho_c.is_a?(Hash) ? autho_c[action_name.to_sym] : autho_c

    case must_be_a
    when guest then redirect_to user_homepage  if hello_session.present?
    when user then  redirect_to guest_homepage if hello_session.blank?
    when either # nothing to do, yay
    else
      raise "No Authorization Rules for '#{controller_name}##{action_name}'"
    end
  end


end
