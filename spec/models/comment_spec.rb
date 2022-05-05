require 'rails_helper'

RSpec.describe Comment, type: :model do
  before(:all) do
    @user = User.create(name: 'Emy', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from France.')
    @post = Post.create(title: 'my post', author: @user)
  end

  it 'should have increments the comment_counter s post after saving the post' do
    expect(@post.comments_counter).to be 0

    comment = Comment.new(author: @user, post: @post)
    comment.save
    expect(@post.comments_counter).to be 1
  end
end
