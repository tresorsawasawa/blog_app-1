require 'rails_helper'

RSpec.describe 'Users', type: :request do
  it 'GET /users succeed' do
    get '/users'
    expect(response).to have_http_status(:ok)
  end

  it 'Redirects to the users list page' do
    get '/users'
    expect(response).to render_template(:index)
    expect(response.body).to include('User name')
    expect(response.body).to include('Number of posts: x')
  end

  it 'GET /users/1 succeed' do
    get '/users/1'
    expect(response).to have_http_status(:ok)
  end

  it 'Redirects to the user profile page' do
    get '/users/1'
    expect(response).to render_template(:show)
    expect(response).to_not render_template(:index)
    expect(response.body).to include('Bio')
  end
end
