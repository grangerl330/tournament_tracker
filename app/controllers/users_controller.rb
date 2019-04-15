class UsersController < ApplicationController
  before_action :require_login, :set_user, only: [:show, :edit, :update, :destroy]

  def new
    @new = true
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to user_path(@user)
    else
      flash[:alert] = "*Email already taken. Please enter valid email"
      render new_user_path
    end
  end

  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)
      @user.update(user_params)
      redirect_to user_path(@user)
    else
      flash[:alert] = "*Email already taken. Please enter valid email"
      redirect_to edit_user_path(@user)
    end
  end

  def destroy
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :name, :image, :uid)
  end

  def set_user
    @user = current_user
  end
end
