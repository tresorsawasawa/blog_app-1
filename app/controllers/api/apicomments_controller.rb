class Api::ApicommentsController < ApplicationController
  before_action :authenticate, only: [:create]
  skip_before_action :verify_authenticity_token

  def index
    return render json: { error: 'Post not found' } unless Post.exists?(params[:id])

    @comments = Comment.where(post_id: params[:id])
    render json: @comments
  end

  def create
    return render json: { error: 'Post not found' } unless Post.exists?(params[:id])

    Comment.create(post_id: params[:id], author_id: @user_logged.id, text: params[:text])
    redirect_to api_comments_path(id: params[:id])
  end

  private

  def authenticate
    token = JsonWebToken.decode(params[:token])
    user_id = token['user_id']
    return render json: { error: 'User not found' } unless User.exists?(user_id)

    @user_logged = User.find(user_id)
  end
end
