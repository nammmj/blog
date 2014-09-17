class CommentsController < ApplicationController
 	load_and_authorize_resource except: [:create]
  def create
    @post = Post.find(params[:article_id])
     @comment = @post.comments.create(params[:comment].permit(:commenter, :body))
    redirect_to article_path(@post)
  end
 
  private
    def comment_params
      params.require(:comment).permit(:commenter, :body)
    end
end