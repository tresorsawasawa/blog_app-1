require 'rails_helper'

RSpec.describe 'Post show page', type: :system do
  describe 'User index page' do
    before(:each) do
      @user = User.create!(name: 'Amy', photo: '#photo_hello', bio: 'My bio #amy !', email: 'amy@test.com',
                           password: 'azerty123', posts_counter: 0)
      @userb = User.create!(name: 'Tomy', photo: '#photo_tomy', bio: 'My bio Tomy !', email: 'tomy@test.com',
                            password: 'azerty123', posts_counter: 0)

      @p = Post.create(author: @user, title: '#My Post', text: 'This is my first post')

      @c = Comment.create(post: @p, author: @userb, text: 'Hi Amy!')

      visit new_user_session_path
      fill_in 'user_email',	with: 'hello@test.com'
      fill_in 'user_password',	with: 'azerty123'
      click_button 'Log in'
      visit user_post_path(@user.id, @p.id)
    end

    after(:each) do
      User.destroy_all
    end

    it 'I can see the post s title.' do
      expect(page).to have_content '#My Post'
    end

    it 'I can see who wrote the post.' do
      expect(page).to have_content @user.name
    end

    it 'I can see how many comments and like it has.' do
      expect(page).to have_content 'Comment: 1, Likes : 0'
    end

    it 'I can see the post body' do
      expect(page).to have_content 'This is my first post'
    end

    it 'I can see the username of each commentor.' do
      expect(page).to have_content 'Tomy'
    end

    it 'I can see the comment each commentor left.' do
      expect(page).to have_content 'Hi Amy!'
    end
  end
end
