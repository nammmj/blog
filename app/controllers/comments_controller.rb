class CommentsController < ApplicationController
	load_and_authorize_resource # Authenticate with Gem Cancan
	
	def new
		@comment = Comment.new()
	end
	def create
		@post = Post.find(params[:post_id])
		@comment = @post.comments.new(comment_params)
		if @comment.save
			redirect_to post_path(@post)
		else
			flash[:notice] = "Error, can not create comment"
			redirect_to post_path(@post)
		end
	end
	def destroy
		@post = Post.find(params[:post_id])
		@comment = Comment.find(params[:id])
		
		if @comment.destroy
			redirect_to post_path(@post), notice: "Delete comment suceesfully"
		else
			redirect_to post_path(@post), notice: "Can not delete this comment"
		end 
	end

	private
	def comment_params
		params.require(:comment).permit(:commenter, :body)
	end
end
