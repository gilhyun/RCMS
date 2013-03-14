class CommentsController < ApplicationController

	def index

		@document=Document.find(params[:document_id])

		respond_to do |format|
		  @comments=@document.comments.list_updated(params[:comments_page])
	      format.js{ render "ajax-comment", locals:{page:"comments"} } 
	    end
	end

	def edit
		@document=Document.find(params[:document_id])
		@comment = @document.comments.find(params[:id])
		respond_to do |format|
			format.js{ render "ajax-edit", locals:{page:"edit"} } 
		end
	end

	def update
		@document=Document.find(params[:document_id])
		@comment = @document.comments.find(params[:id])
		respond_to do |format|
			if @comment.update_attributes(params[:comment])
				format.js{ render "ajax-comment", locals:{page:"comments"} } 
			end
		end
	end


	def create
		@document=Document.find(params[:document_id])
		@comment = @document.comments.new(params[:comment])

	    respond_to do |format|
	      if @comment.save
	      	@comments=Comment.list_updated(params[:comments_page])
	        format.js{ render "ajax-comment", locals:{page:"comments"} } 
	      else
	      	@comments=Comment.list_updated(params[:comments_page])
	        format.js{ render "ajax-comment", locals:{page:"comments"} } 
	      end
	    end
	end

	def destroy
		# document 의 counter_cache 값인 comments_count도 알아서 바뀐다.
	    @comment = Comment.find(params[:id])
	    @comment.destroy
	    respond_to do |format|
	      format.all{ redirect_to document_path(params[:document_id])}
	    end
	end

end
