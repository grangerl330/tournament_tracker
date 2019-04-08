class ApplicationController < ActionController::Base
  before_action :current_user
  helper_method :current_user, :logged_in?

  def welcome
    render :layout => false
  end

  private

  def logged_in?
    session[:user_id]
  end

  def require_login
    redirect_to login_path unless logged_in?
  end

  def current_user
    @user ||= User.find(session[:user_id]) if logged_in?
  end

end
