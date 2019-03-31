class MiddlewareController < ApplicationController
  def bad_kitty
    render plain: '200 OK'
  end
end
