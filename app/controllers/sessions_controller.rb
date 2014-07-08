class SessionsController < ApplicationController

  def new
    if request.referrer
      session[:login_referrer] = request.referrer
    end

    render layout: 'barebone'
  end

  def create
    user = User.find_by(username: params[:username])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:notice] = "Welcome back, #{params[:username]}"

      if session[:login_referrer]
        redirect_to session.delete(:login_referrer)
      else
        redirect_to root_path
      end
    else
      flash.now[:error] = "Incorrect username or password"
      render "new", layout: 'barebone'
    end

  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "Bye bye, you've logged out!"

    if request.referrer && request.referrer != logout_url
      redirect_to request.referrer
    else
      redirect_to root_path
    end
  end


end