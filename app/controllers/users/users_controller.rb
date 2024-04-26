class Users::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post

  def show
    @user = User.find(params[:id])
  end

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to user_path(params[:id])
    else
      render :edit
    end
  end

  private

  def set_post
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :introduction)
  end
end
