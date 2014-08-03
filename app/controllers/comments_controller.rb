class CommentsController < ApplicationController
  before_action :require_user, only: [:create, :vote]

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

  def vote
    comment = Comment.find(params[:id])
    vote_up = params[:vote] == 'true'
    
    if Vote.where(voteable: comment, creator: current_user, vote: vote_up).exists?
      flash[:error] = "You can only vote for a comment once"
      
    elsif Vote.where(voteable: comment, creator: current_user).exists?
      Vote.find_by(voteable:comment, creator: current_user).destroy
      Vote.create(voteable: comment, creator: current_user, vote: vote_up)
      flash[:notice] = "You've changed your vote for the comment"

    else
      Vote.create(voteable: comment, creator: current_user, vote: vote_up)
      flash[:notice] = "You've voted for the comment"
    end
    
    redirect_to :back
  end

end