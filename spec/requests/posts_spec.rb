require 'rails_helper'

RSpec.describe 'Posts Controller', type: :request do
  it 'GET users/1/posts succeed' do
    get '/users/1/posts'
    expect(response).to have_http_status(:ok)
  end

  it "Redirects to the users posts's list page" do
    get '/users/1/posts'
    expect(response).to render_template(:index)
    expect(response.body).to include('Post #1')
    expect(response.body).to include('Post #2')
  end

  it 'GET users/1/posts/1 succeed' do
    get '/users/1/posts/1'
    expect(response).to have_http_status(:ok)
  end

  it 'Redirects to the post profile page' do
    get '/users/1/posts/1'
    expect(response).to render_template(:show)
    expect(response).to_not render_template(:index)
    expect(response.body).to include('Username: Comment 10 ')
  end
end
