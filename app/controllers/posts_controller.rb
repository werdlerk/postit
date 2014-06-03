class PostsController < ApplicationController
  before_action :get_post, only: [:show, :edit, :update]

  def index
    @posts = Post.all
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
    @post.creator = User.find(1)

    if @post.save
      flash[:notice] = "Your post has been created."
      redirect_to posts_path
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


  private

  def post_params
    # require(..).permit! to permit everything 
    params.require(:post).permit(:title, :url, :description)
  end

  def get_post
    @post = Post.find(params[:id])
  end
end
