class PostsController < ApplicationController
  before_action :require_post_author_to_change_post, only: [:edit, :update, :destroy]

  def create
    @post = Post.new(post_params)
    if @post.save
      render :show
    else
      flash[:errors] = @post.errors.full_messages
      render :new
    end
  end

  def new
    @post = Post.new
  end

  def edit
    @post = Post.find(params[:id])
  end

  def show
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update
      render :show
    else
      flash[:errors] = @post.errors.full_messages
      render :show
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @sub = Sub.find_by_id(@post.sub_id)
    @post.destroy
    flash[:errors] = ["That post has been deleted!"]
    redirect_to sub_url(@sub)
  end

  private
  def post_params
    params.require(:post).permit(:title, :content)
  end

  def require_post_author_to_change_post
    @post = Post.find(params[:id])
    unless @post.author == current_user
      flash[:errors] = ["You must be this post's author to make changes."]
      redirect_to sub_url(@sub)
    end
  end
end
