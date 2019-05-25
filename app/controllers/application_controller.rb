class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception


  helper_method :current_user, :cart, :logged_in?

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logout
    reset_session
    redirect_to root_path
    flash[:message] = "You are logged out"
  end

  def cart
    @cart ||= Cart.new(session[:cart])
  end

  def logged_in?
    !current_user.nil?
  end
end
