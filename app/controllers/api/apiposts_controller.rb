class Api::ApipostsController < ApplicationController
  layout false

  def index
    return unless User.exists?(params[:id])

    @posts = Post.where(author_id: params[:id])
    render json: @posts
  end
end
