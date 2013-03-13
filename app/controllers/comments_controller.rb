class CommentsController < ApplicationController

	def index

		@document=Document.find(params[:document_id])

		respond_to do |format|
		  @comments=@document.comments.list_updated(params[:comments_page])
	      format.js{ render "ajax-comment" } 
	    end
	end


	def create
		@document=Document.find(params[:document_id])
		@comment = @document.comments.new(params[:comment])

	    respond_to do |format|
	      if @comment.save
	      	@comments=Comment.list_updated(params[:comments_page])
	        format.js{ render "ajax-comment" } 
	      else
	      	@comments=Comment.list_updated(params[:comments_page])
	        format.js{ render "ajax-comment" } 
	      end
	    end
	end

end
