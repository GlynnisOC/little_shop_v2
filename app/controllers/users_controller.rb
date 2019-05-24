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
      redirect_to controller: 'users', action: 'profile', new_id: @user.id
    else
      !@user.save
      flash[:missing_fields] = "You are missing required fields to register."
      render :new
    end
  end

  def show
  end

  def profile
    if params[:new_id] != nil
      @user = User.find(params[:new_id])
    else
      @user = User.find(current_user.id)
      flash[:logged_in] = "#{@user.name}, you're already logged in!"
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :address, :city, :state, :zip, :email, :password)
  end
end
