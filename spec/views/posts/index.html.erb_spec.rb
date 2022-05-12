require 'rails_helper'

RSpec.describe 'User post index page', type: :system do
  describe 'User post index page' do
    before(:each) do
      @user = User.create!(name: 'Hello', photo: '#photo_hello', bio: 'My bio #hello !', email: 'hello@test.com',
                           password: 'azerty123', posts_counter: 0)

      10.times do |i|
        @p = Post.create(author: @user, title: "#{i}/ Post ", text: "This is my #{i} post")
      end

      @c = Comment.create(post: @p, author: @user, text: 'Hi Tom!')

      Like.create(author: @user, post: @p)
      Like.create(author: @user, post: @p)

      visit new_user_session_path
      fill_in 'user_email',	with: 'hello@test.com'
      fill_in 'user_password',	with: 'azerty123'
      click_button 'Log in'
      visit user_posts_path(@user.id)
    end

    after(:each) do
      User.destroy_all
    end

    it 'I can see the user s profile picture' do
      expect(page.find("#user_#{@user.id} img")['src']).to have_content @user.photo
    end

    it 'I can see the user s username.' do
      expect(page).to have_content @user.name
    end

    it 'I can see the number of posts the user has written.' do
      expect(page).to have_content 'Number of posts: 10'
    end

    it 'I can see a post s title.' do
      expect(page).to have_content '9/ Post'
    end

    it 'I can see some of the post s body.' do
      expect(page).to have_content 'This is my 9 post'
    end

    it 'I can see the first comments on a post.' do
      expect(page).to have_content 'Hi Tom!'
    end

    it 'I can see how many comments and like a post has.' do
      expect(page).to have_content 'Comment: 1, Likes : 2'
    end

    it 'I can see a section for pagination if there are more posts than fit on the view.' do
    end

    it 'When I click on a post, it redirects me to that post s show page' do
      visit user_post_path(@user.id, @p.id)
      expect(page).to have_content 'Add new Comment'
      expect(page).to have_content 'Add a like'
      expect(page).to have_content 'Delete the post'
    end
  end
end
