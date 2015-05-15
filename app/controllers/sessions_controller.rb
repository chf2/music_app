class SessionsController < ApplicationController
  def new
    redirect_to bands_url if logged_in? && current_user.activated
  end

  def create
    user = User.find_by_credentials(
      params[:user][:email],
      params[:user][:password]
      )
    if user
      login(user)
      flash[:success] = "Welcome back!"
      redirect_to user_url(user)
    else
      flash[:errors] = "Invalid credentials"
      render :new
    end
  end

  def destroy
    logout!
    redirect_to new_session_url
  end
end
