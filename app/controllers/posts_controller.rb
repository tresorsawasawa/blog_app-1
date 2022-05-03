class PostsController < ApplicationController
  def index
    @user = current_user
  end

  def new
    
  end

  def show
    @post = Post.find(params[:id])
  end
end
