class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      if user.default?
        redirect_to profile_path
      elsif user.merchant?
        redirect_to dashboard_path
      elsif user.admin?
        redirect_to root_path
      end
      flash[:message] = "Logged in as #{user.name}"
    else
      redirect_to login_path
      flash[:message] = "The email or password you entered was incorrect."
    end
  end

end
