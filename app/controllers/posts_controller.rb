class PostsController < ApplicationController
  before_action :get_post, only: [:show, :edit, :update, :vote]
  before_action :require_user, except: [:show, :index]
  before_action :require_creator, only: [:edit, :update]

  def index
    @posts = Post.all.newest_first
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
    
    if Vote.where(voteable: @post, creator: current_user, vote: vote_up).exists?
      flash[:error] = "You can only vote for a post once"
      
    elsif Vote.where(voteable: @post, creator: current_user).exists?
      Vote.find_by(voteable:@post, creator:current_user).destroy
      Vote.create(voteable: @post, creator: current_user, vote: vote_up)
      flash[:notice] = "You've changed your vote for post <i>'#{@post.title}'</i>.".html_safe

    else
      Vote.create(voteable: @post, creator: current_user, vote: vote_up)

      flash[:notice] = "You've voted for post <i>'#{@post.title}'</i>.".html_safe
    end
    
    redirect_to :back
  end


  private

  def post_params
    # require(..).permit! to permit everything 
    params.require(:post).permit(:title, :url, :description, category_ids: [])
  end

  def get_post
    @post = Post.find(params[:id])
  end

  private

  def require_creator
    if @post.creator != current_user
      flash[:error] = "This operation is not permitted."
      redirect_to post_path(@post)
    end
  end
end
