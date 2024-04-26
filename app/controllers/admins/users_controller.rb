class Admins::UsersController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_user, only: [:show, :destroy]

  def index
    @users = User.all
  end

  def show; end

  def destroy
    @user.destroy
    redirect_to admins_users_path
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
