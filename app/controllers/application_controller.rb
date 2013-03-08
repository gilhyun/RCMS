class ApplicationController < ActionController::Base
  protect_from_forgery

  def upload_path
	puts "#{Rails.root}#{ENV["UPLOAD_PATH"]}"
  end
end
