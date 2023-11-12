require 'swagger_helper'

RSpec.describe 'v1/baskets', type: :request do

  path '/v1/users/{user_id}/baskets' do

    parameter name: 'Authorization', in: :header, type: :string, description: 'Token received from login', required: true
    parameter name: 'user_id', in: :path, type: :string, description: 'Id of the user'

    get('show basket') do
      response(200, 'successful') do
        let(:Authorization) { User.find(1).jwt }
        let(:user_id) { 1 }
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end

      response(401, 'Unauthorized') do
        run_test!
      end
    end

    patch('update basket') do
      parameter name: :body, in: :body, required: true, schema: {
        type: :object,
        properties: {
          product_id: { type: :integer },
          amount: { type: :integer }
        },
        required: ['email', 'password']
      }
      response(200, 'successful') do
        let(:user_id) { '123' }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end

      response(401, 'Unauthorized') do
        run_test!
      end
    end

    delete('delete basket') do
      response(200, 'successful') do
        let(:user_id) { '123' }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end

      response(401, 'Unauthorized') do
        run_test!
      end
    end
  end
end
