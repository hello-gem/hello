require "hello/rails/controller/locale_concern"
require "hello/rails/controller/time_zone_concern"
require "hello/rails/controller/user_concern"
require "hello/rails/controller/access_token_concern"
require "hello/rails/controller/access_token_session_concern"
require "hello/rails/controller/access_token_creator_concern"
require "hello/rails/controller/kicking_concern"
require "hello/rails/controller/sudo_mode_concern"
require "hello/rails/controller/impersonation_concern"
require "hello/rails/controller/others_concern"

if defined? ActionController::Base
  ActionController::Base.class_eval do
    include Hello::Rails::Controller::LocaleConcern
    include Hello::Rails::Controller::TimeZoneConcern
    include Hello::Rails::Controller::UserConcern
    include Hello::Rails::Controller::AccessTokenConcern
    include Hello::Rails::Controller::AccessTokenSessionConcern
    include Hello::Rails::Controller::AccessTokenCreatorConcern
    include Hello::Rails::Controller::KickingConcern
    include Hello::Rails::Controller::SudoModeConcern
    include Hello::Rails::Controller::ImpersonationConcern
    include Hello::Rails::Controller::OthersConcern
  end
end
