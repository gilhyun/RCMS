
class PageController < ApplicationController
 
  def routing_error
    p "routing error path: #{params[:path]}"
    render template:"error/500"
  end
 
end