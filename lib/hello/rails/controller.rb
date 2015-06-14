require "hello/rails/controller/locale_concern"
require "hello/rails/controller/time_zone_concern"
require "hello/rails/controller/access_token_concern"
require "hello/rails/controller/access_restriction_concern"
require "hello/rails/controller/sudo_mode_concern"

if defined? ActionController::Base
  ActionController::Base.class_eval do
    include Hello::Rails::Controller::LocaleConcern
    include Hello::Rails::Controller::TimeZoneConcern
    include Hello::Rails::Controller::AccessTokenConcern
    include Hello::Rails::Controller::AccessRestrictionConcern
    include Hello::Rails::Controller::SudoModeConcern
  end
end
