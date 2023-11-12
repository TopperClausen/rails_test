require 'swagger_helper'

RSpec.describe 'v1/sessions', type: :request do

  path '/v1/sessions' do

    parameter name: :body, in: :body, required: true, schema: {
        type: :object,
        properties: {
          email: { type: :string },
          password: { type: :string }
        },
        required: ['email', 'password']
      }

    post('create session') do
      response(200, 'successful') do
        run_test!
      end

      response(401, 'Unauthorized') do
        run_test!
      end
    end
  end
end
