require 'rails_helper'

RSpec.describe Post, type: :model do
  before(:all) do
    @user = User.create(name: 'Emy', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from France.')
    @post = Post.create(title: 'my post', author: @user)
  end

  it 'should have title not equal to nil' do
    @post.title = nil
    expect(@post).to_not be_valid
  end

  it 'should have title not empty' do
    @post.title = ''
    expect(@post).to_not be_valid

    @post.title = 'my post'
    expect(@post).to be_valid
  end

  it 'should have title max length 250' do
    @post.title = 'a' * 251
    expect(@post).to_not be_valid

    @post.title = 'b' * 250
    expect(@post).to be_valid
  end

  it 'should have post comments_counter higher or grater than 0' do
    @post.comments_counter = -20
    expect(@post).to_not be_valid

    @post.comments_counter = 0
    expect(@post).to be_valid

    @post.comments_counter = 20
    expect(@post).to be_valid
  end

  it 'should have comments_counter numericaly' do
    @post.comments_counter = 'test'
    expect(@post).to_not be_valid

    @post.comments_counter = 20
    expect(@post).to be_valid
  end

  it 'should have post likes_counter higher or grater than 0' do
    @post.likes_counter = -20
    expect(@post).to_not be_valid

    @post.likes_counter = 0
    expect(@post).to be_valid

    @post.likes_counter = 20
    expect(@post).to be_valid
  end

  it 'should have likes_counter numericaly' do
    @post.likes_counter = 'test'
    expect(@post).to_not be_valid

    @post.likes_counter = 20
    expect(@post).to be_valid
  end

  it 'should have increments the posts_counter s author after saving the post' do
    expect(@user).to be_valid
    expect(@user.posts_counter).to be 1

    @post.save
    expect(@user.posts_counter).to be 2
  end

  it 'should return less than 6 comments ' do
    value = @post.recent_comments.length
    expect(value).to be < 6
  end
end
