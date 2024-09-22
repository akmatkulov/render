# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_user, only: %i[show]
  before_action :logged_in_user, only: %i[index edit update destroy]
  before_action :correct_user, only: %i[edit update]
  before_action :admin_user, only: :destroy
  def new
    @user = User.new
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = 'User deleted'
    redirect_to users_path, status: :see_other
  end

  def index
    @pagy, @users = pagy(User.all)
  end

  def show; end

  def edit; end

  def update
    if @user.update(user_params)
      flash[:success] = 'User updated!'
      redirect_to user_path(@user)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in(@user)
      flash[:success] = 'Welcome to the Sample App'
      redirect_to @user
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url, status: :see_other) unless
current_user?(@user)
  end

  def admin_user
    redirect_to(root_path) unless current_user.admin?
  end

  def logged_in_user
    return if logged_in?

    store_location
    flash[:danger] = 'Please log in.'
    redirect_to login_path
  end

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
