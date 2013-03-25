class ApplicationController < ActionController::Base
  protect_from_forgery

  # I18n
  before_filter :set_locale
 
  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end
  
  def default_url_options(options={})
    #logger.debug "default_url_options is passed options: #{options.inspect}\n"
    { :locale => I18n.locale }
  end

  
  #rescue_from Exception, :with => :render_500 # 혹은 do block
  #rescue_from ActiveRecord::RecordNotFound , :with => :render_404
  
  private

    def render_404
      render :template => 'errors/404', :layout => false, :status => :not_found
    end

    def render_500
      render :template => 'errors/500', :layout => false, :status => :internal_server_error
    end

    def current_user
      @current_user ||= User.find(session[:userid]) if session[:userid]
      redirect_to new_session_path unless @current_user
    end

    helper_method :current_user

end
