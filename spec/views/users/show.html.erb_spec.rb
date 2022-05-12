require 'rails_helper'

RSpec.describe 'User index page', type: :system do
  describe 'User index page' do
    before(:each) do
      @user = User.create!(name: 'Hello', photo: '#photo_hello', bio: 'My bio #hello !', email: 'hello@test.com',
                           password: 'azerty123', posts_counter: 0)

      10.times do |i|
        @p = Post.create(author: @user, title: "#{i}/ Post ", text: "This is my #{i} post")
      end

      visit new_user_session_path
      fill_in 'user_email',	with: 'hello@test.com'
      fill_in 'user_password',	with: 'azerty123'
      click_button 'Log in'
      visit user_path(@user.id)
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

    it 'I can see the user s bio' do
      expect(page).to have_content 'My bio #hello !'
    end

    it 'I can see the user s first 3 posts.' do
      expect(page).to have_content 'This is my 9 post'
      expect(page).to have_content 'This is my 8 post'
      expect(page).to have_content 'This is my 7 post'
    end

    it 'I can see a button that lets me view all of a users posts.' do
      expect(page).to have_content 'See all posts'
    end

    it 'When I click a user s post, it redirects me to that post s show page.' do
      visit user_post_path(@user.id, @p.id)
      expect(page).to have_content 'Add new Comment'
      expect(page).to have_content 'Add a like'
      expect(page).to have_content 'Delete the post'
    end

    it 'When I click to see all posts, it redirects me to the user s post s index page.' do
      visit user_posts_path(@user.id)

      10.times do |i|
        expect(page).to have_content "This is my #{i} post"
      end
    end
  end
end
