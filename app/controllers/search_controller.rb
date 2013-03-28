class SearchController < ApplicationController

	before_filter :current_user
	
	def search

	  query=  params[:query].gsub('%','\%').gsub('_','\_')

	  session[:search] ||="document"

	  logger.debug "session : #{session[:search]}"

	  if session[:search]=="document"
	  	document_search(query)
	  elsif session[:search]=="admin_document"
	  	document_admin_search(query)
	  elsif session[:search]=="user"
	  	user_search(query)
	  elsif session[:search]=="category"
	  	category_search(query)
		end

	end

private

	def document_search(query)
		@documents = Document.find(:all, :conditions=> ["title like ? or content like ?",  "%#{query}%", "%#{query}%"])
		@documents=Kaminari.paginate_array(@documents).page(params[:page]).per(search_options[:search_per])
		respond_to do |format|
      format.js{ render "ajax.js" , locals:{page:"list"} } 
    end
  end

  # 관리자가 문서를 검색하는 경우 
  def document_admin_search(query)
		@documents = Document.joins(:category).select("categories.*, documents.*").find(:all, :conditions=> ["name like ? or description like ? or title like ? or content like ?",  "%#{query}%","%#{query}%","%#{query}%", "%#{query}%"])
		@documents=Kaminari.paginate_array(@documents).page(params[:page]).per(search_options[:search_per])
		respond_to do |format|
      format.js{ render "ajax.js" , locals:{page:"admin/documents/list"} } 
    end
  end

  def user_search(query)
		@users = User.find(:all, :conditions=> ["userid like ? or email like ?",  "%#{query}%", "%#{query}%"])
		@users=Kaminari.paginate_array(@users).page(params[:page]).per(search_options[:search_per])
		respond_to do |format|
      format.js{ render "ajax.js" , locals:{page:"list_user"} } 
    end
  end

  def category_search(query)
		@categories = Category.find(:all, :conditions=> ["name like ? or description like ?",  "%#{query}%", "%#{query}%"])
		@categories=Kaminari.paginate_array(@categories).page(params[:page]).per(search_options[:search_per])
		respond_to do |format|
      format.js{ render "ajax.js" , locals:{page:"list_category"} } 
    end
  end


end
