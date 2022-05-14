class Api::ApipostsController < ApplicationController
  layout false

  def index
    return render json: { error: 'User not found' } unless User.exists?(params[:id])

    @posts = Post.where(author_id: params[:id])
    render json: @posts
  end
end
