class CommentsController < ApplicationController
  before_action :require_user, only: [:create, :vote]

  def create
    @post = Post.find_by_slug(params[:post_id])
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
    @comment = Comment.find(params[:id])
    vote_up = params[:vote] == 'true'
    @vote = Vote.new(voteable: @comment, creator: current_user, vote: vote_up)

    if @vote.valid?
      if Vote.destroy_all(voteable: @comment, creator: current_user).any?
        flash[:notice] = "You've changed your vote for the comment"
      else
        flash[:notice] = "You've voted for the comment"
      end
      @vote.save
    else
      flash[:error] = "You can only vote for a comment once"
    end

    respond_to do |format|
      format.html { redirect_to :back }
      format.js { render :vote }
    end
  end

end