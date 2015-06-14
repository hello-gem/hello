require "hello/rails/controller/locale_concern"
require "hello/rails/controller/time_zone_concern"
require "hello/rails/controller/access_token_concern"
require "hello/rails/controller/restriction_concern"
require "hello/rails/controller/sudo_mode_concern"
require "hello/rails/controller/impersonation_concern"

if defined? ActionController::Base
  ActionController::Base.class_eval do
    include Hello::Rails::Controller::LocaleConcern
    include Hello::Rails::Controller::TimeZoneConcern
    include Hello::Rails::Controller::AccessTokenConcern
    include Hello::Rails::Controller::RestrictionConcern
    include Hello::Rails::Controller::SudoModeConcern
    include Hello::Rails::Controller::ImpersonationConcern
  end
end
