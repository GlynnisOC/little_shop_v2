class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to profile_path
      flash[:message] = "Logged in as #{user.name}"
    else
      render :new
    end
  end


end
