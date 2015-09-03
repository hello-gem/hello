require "hello/rails/controller/hello_concern"
#
require "hello/rails/controller/locale_concern"
require "hello/rails/controller/time_zone_concern"
require "hello/rails/controller/kicking_concern"
require "hello/rails/controller/sudo_mode_concern"
require "hello/rails/controller/impersonation_concern"
require "hello/rails/controller/alive_concern"

if defined? ActionController::Base
  ActionController::Base.class_eval do
    include Hello::Rails::Controller::HelloConcern
    #
    include Hello::Rails::Controller::LocaleConcern
    include Hello::Rails::Controller::TimeZoneConcern
    include Hello::Rails::Controller::KickingConcern
    include Hello::Rails::Controller::SudoModeConcern
    include Hello::Rails::Controller::ImpersonationConcern
    include Hello::Rails::Controller::AliveConcern
  end
end
