require 'rails_helper'

RSpec.describe 'User index page', type: :system do
  describe 'User index page' do
    before(:each) do
      @users = [User.create!(name: 'Hello', photo: '#photo_hello', bio: 'bio', email: 'hello@test.com',
                             password: 'azerty123', posts_counter: 0),
                User.create!(name: 'Amy', photo: '#photo_amy', bio: 'bio', email: 'amy@test.com',
                             password: 'azerty123', posts_counter: 10)]

      visit new_user_session_path
      fill_in 'user_email',	with: 'hello@test.com'
      fill_in 'user_password',	with: 'azerty123'
      click_button 'Log in'
    end

    after(:each) do
      User.destroy_all
    end

    it 'I can see the username of all other users.' do
      visit users_path

      @users.each do |u|
        expect(page).to have_content u.name
      end
    end

    it 'I can see the profile picture for each user' do
      visit users_path

      @users.each do |u|
        expect(page.find("#user_#{u.id} img")['src']).to have_content u.photo
      end
    end

    it 'I can see the number of posts each user has written.' do
      visit users_path

      @users.each do |u|
        expect(page).to have_content('Number of posts:')

        expect(page).to have_content u.posts_counter
      end
    end

    it 'When I click on a user, I am redirected to that user s show page.' do
      visit users_path
      click_link @users[0].name
      expect(page).to have_content 'See all posts'
    end
  end
end
