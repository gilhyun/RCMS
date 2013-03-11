class ApplicationController < ActionController::Base
  protect_from_forgery

  private

  def current_user

    @current_user ||= User.find(session[:userid]) if session[:userid]

    redirect_to new_session_path unless @current_user
  end

  helper_method :current_user

end
