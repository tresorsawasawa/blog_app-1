class PostsController < ApplicationController
  def index
    @user = current_user
  end

  def new
    @post = Post.new
    @user = current_user
  end

  def create
    Post.create(post_params)
    flash[:notice] = 'You have successfully created a new post.'
    redirect_to { user_posts(current_user) }
  end

  def show
    @post = Post.find(params[:id])
  end

  private

  def post_params
    p = params.require(:post).permit(:title, :text)
    p[:author] = current_user
    p
  end

  def post_params_setup
    Post.create(author: current_user, title: params[:post][:title], text: params[:post][:text])
  end
end
