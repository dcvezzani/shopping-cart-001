class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def authorize(record)
    raise Errors::NotAuthorizedError unless policy(record).public_send(params[:action] + "?")
  end

  def policy(record)
    "#{record.class}Policy".constantize.new(current_user, record)
  end  

  rescue_from Errors::NotAuthorizedError do
    render text: "Access Denied", status: :unauthorized
  end  

  rescue_from Exception do
    render text: "Server Error", status: 500
  end  
end
