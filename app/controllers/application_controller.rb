class ApplicationController < ActionController::Base

  helper_method :require_logged_in, :require_not_logged_in, :logged_in?, :current_user

  def current_user
    @current_user ||= User.find_by_token(session[:token])
  end

  # @param [User] user
  def login(user)
    session[:token] = user.refresh_token!
    @current_user = user
  end

  def logout
    session[:token] = nil
    current_user.refresh_token!
    @current_user = nil
  end

  def logged_in?
    current_user != nil
  end

  def require_logged_in
    redirect_to new_session_path unless logged_in?
  end

  def require_not_logged_in
    redirect_to user_path(current_user) if logged_in?
  end

end
