class CommentsController < ApplicationController

	before_filter :current_user

	def index

		@document=Document.find(params[:document_id])

		respond_to do |format|
	      format.js{ render "ajax-comment", locals:{page:"comments"} } 
	    end
	end

	def show
		# ajax comment edit 수정후 url 이 아래처럼 바뀐다. comment의 id 값이 있으니..
		# show action을 호출하게 된다.
		#Started GET "/documents/1068177635/comments/70?_method=put&authen

		# 아래처럼 되어야 paging이 정상 처리된다.
		#Started GET "/documents/1068177635?comments_page=2" for 127.0.0.1 at

		# 그래서 , 아래처럼 강제로 목록을 나타내도록 처리했으나...
		# 임시 방편일뿐이다.
		# 방법1 : index
		# 방법2: 혹은 아래처럼..
		#redirect_to document_comments_path(params[:document_id])
		# 방법3 : update 42 라인..format.all 이 ajax에도 반응한다.

		# 방법3을 쓸경우 여기 show action 필요없음.
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
				#format.js{ render "ajax-comment", locals:{page:"comments"} } 
				format.all{ redirect_to document_path(@document)}
			end
		end
	end


	def create
		@document=Document.find(params[:document_id])
		@comment = @document.comments.new(params[:comment])

	    respond_to do |format|
	      if @comment.save
	        format.js{ render "ajax-comment", locals:{page:"comments"} } 
	      else
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
