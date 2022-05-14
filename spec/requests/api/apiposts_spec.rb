require 'swagger_helper'

# rubocop:disable Metrics/BlockLength

RSpec.describe 'api/apiposts', type: :request do
  path '/api/users/{id}/posts' do
    # You'll want to customize the parameter types...
    parameter name: 'id', in: :path, type: :string, description: 'id'
    get('list apiposts') do
      consumes 'application/json'
      produces 'application/json'
      parameter name: 'id', in: :path, type: :string, description: 'id of the user'
      response(200, 'successful') do
        schema type: :array,
               items: {
                 type: :object,
                 properties: {
                   id: { type: :integer },
                   title: { type: :string },
                   text: { type: :string },
                   comments_counter: { type: :integer },
                   likes_counter: { type: :integer },
                   created_at: { type: :string },
                   updated_at: { type: :string },
                   author_id: { type: :integer }
                 }
               }
        let(:id) { '123' }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
  end
end

# rubocop:enable Metrics/BlockLength
