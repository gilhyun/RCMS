class ApplicationController < ActionController::Base
  protect_from_forgery

  private

  def current_user
    @current_user ||= User.find(session[:userid]) if session[:userid]

    puts @current_user.id
    puts @current_user.userid
  end

  helper_method :current_user

end
