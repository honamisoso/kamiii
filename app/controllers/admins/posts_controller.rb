class Admins::PostsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_post, only: [:show, :destroy]

  def index
    if params[:tag_id]
      @posts = Tag.find(params[:tag_id]).posts
    else
      @posts = Post.all
    end
  end

  def show; end

  def destroy
    @post.destroy
    redirect_to admins_posts_path
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

end
