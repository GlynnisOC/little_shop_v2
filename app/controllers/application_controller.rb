class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception


  helper_method :current_user,
                :cart,
                :logged_in?,
                :current_admin?,
                :current_visitor?,
                :current_default?,
                :current_merchant?


  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

	def current_admin?
		!current_user.nil? && current_user.admin?
	end

	def current_visitor?
		current_user.nil?
	end

	def current_default?
		!current_user.nil? && current_user.default?
	end

	def current_merchant?
		!current_user.nil? && current_user.merchant?
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

	def not_found
  	raise ActionController::RoutingError.new('Not Found')
	end
end
