#
# IT IS RECOMMENDED THAT YOU DO NOT OVERRIDE THIS FILE IN YOUR APP
#

class Hello::ApplicationController < ApplicationController
  rescue_from Hello::JsonNotSupported do |exception|
    render json: _json_data_for_exception(exception), status: :bad_request
  end

  rescue_from ActionController::ParameterMissing do |exception|
    respond_to do |format|
      format.html { fail exception }
      format.json { render json: _json_data_for_exception(exception), status: :bad_request } # 400
    end
  end

  private

  # Don't override this at home, kids
  def _json_data_for_exception(exception)
    {
      maintenance: false,
      action:      "#{controller_name}##{action_name}",
      exception: {
        class:       exception.class.name,
        message:     exception.message,
        # backtrace:   exception.backtrace
      }
    }
  end
end
