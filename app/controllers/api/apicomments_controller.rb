class Api::ApicommentsController < ApplicationController
  before_action :authenticate, only: [:create]

  def index
    return unless User.exists?(params[:user_id])
    return unless Post.exists?(params[:id])

    @comments = Comment.where(post_id: params[:id], author_id: params[:user_id])
    render json: @comments
  end

  def new
    @user = User.find(params[:user_id])
    @post = Post.find(params[:id])
    @comment = Comment.new
  end

  def create
    return unless User.exists?(params[:user_id])
    return unless Post.exists?(params[:id])

    Comment.create(post_id: params[:id], author_id: params[:user_id], text: params[:comment][:text])
    @comments = Comment.where(post_id: params[:id], author_id: @user_logged.id)
    redirect_to api_comments_path(user_id: params[:user_id], id: params[:id])
  end

  private

  def authenticate
    token = JsonWebToken.decode(params[:comment][:token])
    user_id = token['user_id']
    return unless User.exists?(user_id)

    @user_logged = User.find(user_id)
  end
end
