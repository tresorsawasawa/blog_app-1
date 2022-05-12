require 'rails_helper'

RSpec.describe 'login page', type: :system do
  describe 'login page' do
    it 'I can see the username and password inputs and the Submit button.' do
      visit new_user_session_path
      expect(page).to have_field('user_email')
      expect(page).to have_field('user_password')
      expect(page).to have_button(type: 'submit')
    end

    it 'When I click the submit button without filling in the username and the password, I get a detailed error.' do
      visit new_user_session_path
      click_button 'Log in'
      expect(page).to have_content 'You need to sign in or sign up before continuing.'
    end

    it 'click the submit button after filling fields with incorrect data, I get a detailed error.' do
      visit new_user_session_path
      fill_in 'user_email',	with: 'example@test.com'
      fill_in 'user_password',	with: 'azerty123'
      click_button 'Log in'
      expect(page).to have_content 'Invalid Email or password'
    end

    it 'click the submit button after filling fields with correct data, I am redirected to the root page.' do
      user = User.create!(name: 'test', photo: '#', bio: 'bio', email: 'hello@test.com',
                          password: 'azerty123', posts_counter: 0)

      visit new_user_session_path
      fill_in 'user_email',	with: 'hello@test.com'
      fill_in 'user_password',	with: 'azerty123'
      click_button 'Log in'

      expect(page).to have_content('Signed in successfully')

      user.destroy
    end
  end
end
