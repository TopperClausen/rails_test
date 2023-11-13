require 'swagger_helper'

RSpec.describe 'v1/users', type: :request do

  path '/v1/users' do
    
    parameter name: 'x-api-key', in: :header, type: :string, description: 'Api token', required: true

    parameter name: :body, in: :body, required: true, schema: {
        type: :object,
        properties: {
          full_name: { type: :string },
          email: { type: :string },
          password: { type: :string }
        },
        required: ['email', 'password']
      }
    post('create user') do
      response(200, 'successful') do
        run_test!
      end

      response(400, 'Invalid user') do
        run_test!
      end
    end
  end
end
