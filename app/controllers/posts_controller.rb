class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.creator = User.find(1)

    if @post.save
      flash[:notice] = "Your post has been created."
      redirect_to posts_path
    else
      render 'new'
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])

    if @post.update(post_params)
      flash[:notice] = "Your post has been updated."
      redirect_to posts_path
    else
      render 'edit'
    end
  end


  private

  def post_params
    # require(..).permit! to permit everything 
    params.require(:post).permit(:title, :url, :description)
  end
end
