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
    end
  end

  def edit
    @user = User.find_by(params[:id])
  end

  def update
    new_params = user_params.reject{ |key, value| value == "" }
    current_user.update!(new_params)
    redirect_to profile_path
    flash[:updated_profile] = "#{@current_user.name}, your profile is updated!"
  end

  private
  def user_params
    params.require(:user).permit(:name, :address, :city, :state, :zip, :email, :password)
  end

  # def update_params
  #   if params[:user][:password] == ""
  #     params.require(:user).permit(:name, :address, :city, :state, :zip, :email)
  #   else
  #     user_params
  #   end
  # end
end
