class Admins::PostCommentsController < ApplicationController
  before_action :authenticate_admin!

  def destroy
    Post.find(params[:post_id]).post_comments.find(params[:id]).destroy
    redirect_to admins_post_path(params[:post_id])
  end
end
