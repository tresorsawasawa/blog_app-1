require 'rails_helper'

RSpec.describe User, type: :model do
  before(:all) do
    @user = User.create(name: 'Emy', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from France.')
  end

  it 'should have name not equal to nil' do
    @user.name = nil
    expect(@user).to_not be_valid
  end

  it 'should have name not empty' do
    @user.name = ''
    expect(@user).to_not be_valid

    @user.name = 'Emy'
    expect(@user).to be_valid
  end

  it 'should have post counter higher or grater than 0' do
    @user.posts_counter = -20
    expect(@user).to_not be_valid

    @user.posts_counter = 0
    expect(@user).to be_valid

    @user.posts_counter = 20
    expect(@user).to be_valid
  end

  it 'should have post counter numericaly' do
    @user.posts_counter = 'test'
    expect(@user).to_not be_valid
  end

  it 'should return less than 3 posts ' do
    value = @user.recent_posts.length
    expect(value).to be < 3
  end
end
