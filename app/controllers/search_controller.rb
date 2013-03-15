class SearchController < ApplicationController

	before_filter :current_user
	
	def search

	  query=  params[:query].gsub('%','\%').gsub('_','\_')

	  type=params[:type]

	  if type=="title"

	  	@documents = Document.find(:all, :conditions=> ["title like ?",  "%#{query}%"])
	  
	  elsif type=="content"

	  	@documents = Document.find(:all, :conditions=> ["content like ?",  "%#{query}%"])
	  
	  else
	  
	  	@documents = Document.find(:all, :conditions=> ["title like ? or content like ?",  "%#{query}%", "%#{query}%"])
	  
	  end

	  @documents=Kaminari.paginate_array(@documents).page(params[:page]).per(5)

	  respond_to do |format|
        format.js{ render "ajax" , locals:{page:"list"} } 
      end

	  
	end

end
