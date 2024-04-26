class Users::PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, except: [:index, :new, :create, :search]

  def index
    if params[:tag_id]
      @posts = Tag.find(params[:tag_id]).posts
    else
      @posts = Post.all
    end
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      # タグの保存
      @post.save_tags(params[:post][:tag])
      redirect_to post_path(@post)
    else
      render :new
    end
  end

  def show
    @comment = PostComment.new
  end

  def edit; end

  def update
    if @post.update(post_params)
      # タグの保存
      @post.save_tags(params[:post][:tag])
      redirect_to post_path(@post)
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path
  end

  def search
    @posts = Post.where('title LIKE ? OR body LIKE ?', "%#{params[:keyword]}%", "%#{params[:keyword]}%")
    render 'users/posts/index'
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :body, :evaluation, :post_image).merge(user_id: current_user.id)
  end

end
