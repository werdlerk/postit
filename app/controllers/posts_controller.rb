class PostsController < ApplicationController
  before_action :get_post, only: [:show, :edit, :update]
  before_action :require_user, only: [:new, :create, :edit, :update]
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
    # TODO: change once we have authentication
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
