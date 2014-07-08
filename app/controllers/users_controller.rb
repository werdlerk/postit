class UsersController < ApplicationController
  before_action :require_current_user, only: [:edit]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:notice] = "Welcome, #{@user.username}. You've succesfully registered your account."
      session[:user_id] = @user.id
      redirect_to root_path
    else
      render "new"
    end
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user

    if @user.update(user_params)
      flash[:notice] = "Profile saved"
      redirect_to user_path(@user)
    else
      render "edit"
    end
  end

  def show
    @user = User.find(params[:id])
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end

  def require_current_user
    if current_user.id != params[:id].to_i
      flash[:error] = "Operation forbidden."
      redirect_to user_path(params[:id])
    end
  end

end