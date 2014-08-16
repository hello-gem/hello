require "hello/rails/controller/session_concern"
require "hello/rails/controller/locale_concern"

if defined? ActionController::Base
  ActionController::Base.class_eval do
    include Hello::Rails::Controller::SessionConcern
    include Hello::Rails::Controller::LocaleConcern
  end
end
