class Users::PostCommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @post_comment = current_user.post_comments.new(post_comment_params)
    if @post_comment.save
      redirect_to post_path(params[:post_id])
    else
      @post = Post.find(params[:post_id])
      render 'users/posts/show'
    end
  end

  def destroy
    @post_comment = Post.find(params[:post_id]).post_comments.find(params[:id]).destroy
    redirect_to post_path(params[:post_id])
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:body).merge(user_id: current_user.id, post_id: params[:post_id])
  end
end
