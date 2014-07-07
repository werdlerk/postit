class CommentsController < ApplicationController
  before_action :require_user, only: [:create]

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(params.require(:comment).permit(:body))
    @comment.creator = current_user

    if @comment.save 
      flash[:notice] = "New comment saved."
      redirect_to post_path(@post)
    else
      render "posts/show"
    end

  end

end