class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include ApplicationHelper
  helper_method :logged_in?, :current_user, :rails_auth_token

  def login(user)
    @current_user = user
    session[:session_token] = user.reset_session_token!
  end

  def logout!
    current_user.reset_session_token!
    @current_user, session[:session_token] = nil, nil
  end

  def logged_in?
    !!current_user
  end

  def current_user
    @current_user ||= User.find_by(session_token: session[:session_token])
  end

  def redirect_if_not_logged_in
    redirect_to new_session_url unless logged_in?
  end

end
