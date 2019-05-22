class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    user = User.new(user_params)
    if user.save
      flash[:registered] = "You're logged in!"
      redirect_to '/profile'
    else
      @user = User.new(user_params)
      flash[:missing_fields] = "You are missing required fields to register."
      render :new
    end
  end

  def show
  end

  def profile
		@user = User.find(current_user.id)
  end

  private
  def user_params
    params.require(:user).permit(:name, :address, :city, :state, :zip, :email, :password) ##### , :role, :active)
  end
end
