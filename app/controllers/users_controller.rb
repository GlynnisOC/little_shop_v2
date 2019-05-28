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
    @user = User.find(params[:id])
  end

  def profile
    if params[:new_id] != nil
      @user = User.find(params[:new_id])
    else
      @user = User.find(current_user.id)
      flash[:logged_in] = "#{@user.name}, you're already logged in!"
    end
  end

  def edit
    @user = User.find_by(params[:id])
  end

  def update
    if User.email_taken(update_params[:email]) == true
      redirect_to profile_edit_path
      flash[:email_in_use] = "That email address is taken."
    else
      current_user.update!(update_params)
      redirect_to profile_path
      flash[:updated_profile] = "#{@current_user.name}, your profile is updated!"
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :address, :city, :state, :zip, :email, :password)
  end

  def update_params
    if params[:user][:password] == "" && (params[:user][:email] == current_user.email)
      params.require(:user).permit(:name, :address, :city, :state, :zip)
    elsif
      params[:user][:password] == "" && (params[:user][:email] != current_user.email)
      params.require(:user).permit(:name, :address, :city, :state, :zip, :email)
    else
      user_params
    end
  end
end
