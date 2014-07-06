class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :logged_in?, :not_logged_in?
  
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  def not_logged_in?
    !current_user
  end

  private 

  def require_user
    if not_logged_in?
      flash[:error] = "You need to be logged in to perform this action."
      redirect_to login_path
    end
  end
end
