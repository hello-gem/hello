#
# IT IS RECOMMENDED THAT YOU DO NOT OVERRIDE THIS FILE IN YOUR APP
#

class Hello::ApplicationController < ApplicationController

  rescue_from Hello::JsonNotSupported do |exception|
    data = {
      maintenance: false,
      action:      "#{controller_name}##{action_name}",
      exception: {
        class:       exception.class.name,
        message:     exception.message
      }
    }

    render json: data, status: :bad_request
  end

  rescue_from ActionController::ParameterMissing do |exception|
    data = {
      maintenance: false,
      action:      "#{controller_name}##{action_name}",
      exception: {
        class:       exception.class.name,
        message:     exception.message,
        # backtrace:   exception.backtrace
      }
    }

    respond_to do |format|
      format.html { raise exception }
      format.json { render json: data, status: :bad_request } # 400
    end
  end

end
