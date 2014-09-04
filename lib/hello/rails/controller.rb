require "hello/rails/controller/active_session_concern"
require "hello/rails/controller/locale_concern"
require "hello/rails/controller/helpers_concern"

if defined? ActionController::Base
  ActionController::Base.class_eval do
    include Hello::Rails::Controller::ActiveSessionConcern
    include Hello::Rails::Controller::LocaleConcern
    include Hello::Rails::Controller::HelpersConcern
  end
end
