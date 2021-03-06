class PostsController < ApplicationController
  before_action :get_post, only: [:show, :edit, :update, :vote]
  before_action :require_user, except: [:show, :index, :vote]
  before_action :require_creator_or_admin, only: [:edit, :update]

  def index
    @posts = Post.all.newest_first.sort_by { |post| post.votes_total }.reverse
  end

  def show
    @comment = Comment.new
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.creator = current_user

    if @post.save
      flash[:notice] = "Your post has been created."
      redirect_to post_path(@post)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      flash[:notice] = "Your post has been updated."
      redirect_to post_path(@post)
    else
      render :edit
    end
  end

  def search
    @search = params[:q]
    if @search.empty?
      redirect_to root_path
    else
      @posts = Post.where("title like :searchterms or description like :searchterms", {searchterms: "%#{@search}%"})
    end
  end

  def vote
    vote_up = params[:vote] == 'true'
    @vote = Vote.new(voteable: @post, creator: current_user, vote: vote_up)

    if @vote.valid?
      if Vote.destroy_all(voteable: @post, creator: current_user).any?
        flash.now[:notice] = "You've changed your vote for post <i>'#{@post.title}'</i>.".html_safe
      else
        flash.now[:notice] = "You've voted for post <i>'#{@post.title}'</i>.".html_safe
      end
      @vote.save
    else
      flash.now[:error] = "You can only vote for a post once"
    end

    respond_to do |format|
      format.html { redirect_to :back }
      format.js { render :vote }
    end
  end


  private

  def post_params
    # require(..).permit! to permit everything 
    params.require(:post).permit(:title, :url, :description, category_ids: [])
  end

  def get_post
    @post = Post.find_by_slug(params[:id])
  end

  private

  def require_creator_or_admin
    access_denied unless logged_in? and (@post.creator == current_user || current_user.admin?)
  end
end
