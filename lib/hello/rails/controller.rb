require_relative "controller/hello_concern"
#
require_relative "controller/locale_concern"
require_relative "controller/time_zone_concern"
require_relative "controller/kicking_concern"
require_relative "controller/sudo_mode_concern"
require_relative "controller/impersonation_concern"
require_relative "controller/alive_concern"

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
