class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts.includes(:comments)
  end

  def new
    @post = Post.new
    @user = current_user
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      flash[:notice] = 'You have successfully created a new post.'
      redirect_to { user_posts(current_user) }
    else
      flash[:alert] = 'Can not add a new post.'
      redirect_to { new_user_post(current_user) }
    end
  end

  def show
    @post = Post.includes(:comments).find(params[:id])
  end

  def destroy
    post = Post.find(params[:id])
    post.likes.destroy_all
    post.comments.destroy_all
    post.destroy
    post.author.posts_counter = post.author.posts_counter - 1
    post.save
    p user_path(params[:user_id])
    redirect_to user_path(params[:user_id])
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
