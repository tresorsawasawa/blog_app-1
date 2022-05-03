class CommentsController < ApplicationController
  def new
    @comment = Comment.new
    @user = current_user
  end

  def create
    post = Post.find(params[:post_id])
    Comment.create(post_params(post))
    redirect_to user_post_path(current_user, post)
  end

  private

  def post_params(post)
    p = params.require(:comment).permit(:text)
    p[:author] = current_user
    p[:post] = post
    p
  end
end
