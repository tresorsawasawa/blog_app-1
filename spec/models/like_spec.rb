require 'rails_helper'

RSpec.describe Like, type: :model do
  before(:all) do
    @user = User.create(name: 'Emy', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from France.')
    @post = Post.create(title: 'my post', author: @user)
  end

  it 'should have increments the like_counter s post after saving the post' do
    expect(@post.likes_counter).to be 0

    like = Like.new(author: @user, post: @post)
    like.save
    expect(@post.likes_counter).to be 1
  end
end
