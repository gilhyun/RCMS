class ApplicationController < ActionController::Base
  protect_from_forgery

  #unless  Rails.application.config.consider_all_requests_local
  
    rescue_from Exception, :with => :render_404 # 혹은 do block
    rescue_from ActiveRecord::RecordNotFound , :with => :render_404
  #end
  
  private

    def render_404
      render :text => 'ERRORS', :layout => false, :status => :not_found
    end


    def current_user
      @current_user ||= User.find(session[:userid]) if session[:userid]
      redirect_to new_session_path unless @current_user
    end

    helper_method :current_user

end
