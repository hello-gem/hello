require_relative 'controller/hello_concern'
#
require_relative 'controller/locale_concern'
require_relative 'controller/time_zone_concern'
require_relative 'controller/kicking_concern'
require_relative 'controller/sudo_mode_concern'
require_relative 'controller/alive_concern'

if defined? ActionController::Base
  ActionController::Base.class_eval do
    include Hello::Railsy::Controller::HelloConcern
    #
    include Hello::Railsy::Controller::LocaleConcern
    include Hello::Railsy::Controller::TimeZoneConcern
    include Hello::Railsy::Controller::KickingConcern
    include Hello::Railsy::Controller::SudoModeConcern
    include Hello::Railsy::Controller::AliveConcern
  end
end
