module Hello
  class ApplicationController < ActionController::Base
    include BeforeActions::Controller

    layout "application"

    puts "there should be authorization for these controllers"
  end
end
