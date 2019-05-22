class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    user = User.create!(user_params)   ####### change to new and a save
    redirect_to '/profile'
    if user.save
      flash[:registered] = "You're logged in!"
    end
  end

  def show
  end

  def profile
  end

  private
  def user_params
    params.require(:user).permit(:name, :address, :city, :state, :zip, :email, :password) ##### , :role, :active)
  end
end
