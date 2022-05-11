class CommentsController < ApplicationController
  def new
    @comment = Comment.new
    @user = current_user
  end

  def create
    post = Post.find(params[:post_id])
    @comment = Comment.new(post_params(post))

    if @comment.save
      flash[:notice] = 'You have successfully created a comment.'
      redirect_to user_post_path(current_user, post)
    else
      flash[:alert] = 'Can not add a comment.'
      redirect_to { new_user_post(current_user) }
    end
  end

  def destroy
    comment = Comment.find(params[:id])
    comment.post.comments_counter = comment.post.comments_counter - 1
    comment.destroy
    redirect_to { user_posts(current_user) }
  end

  private

  def post_params(post)
    p = params.require(:comment).permit(:text)
    p[:author] = current_user
    p[:post] = post
    p
  end
end
