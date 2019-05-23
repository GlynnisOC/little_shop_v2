class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if
      User.email_taken(@user.email)
      flash[:email_in_use] = "That email address is taken."
      render :new
    elsif
      @user.save
      flash[:registered] = "You're logged in!"
      redirect_to '/profile'
    else
      !@user.save
      flash[:missing_fields] = "You are missing required fields to register."
      render :new
    end
  end

  def show
  end

  def profile
  end

  private
  def user_params
    params.require(:user).permit(:name, :address, :city, :state, :zip, :email, :password)
  end
end
