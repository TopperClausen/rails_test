require 'swagger_helper'

RSpec.describe 'v1/orders', type: :request do

  path '/v1/users/{user_id}/orders' do
    parameter name: 'x-api-key', in: :header, type: :string, description: 'Api token', required: true
    parameter name: 'Authorization', in: :header, type: :string, description: 'Token received from login', required: true
    parameter name: 'user_id', in: :path, type: :string, description: 'user_id'

    get('list orders') do
      response(200, 'successful') do
        run_test!
      end

      response(401, 'Unauthorized') do
        run_test!
      end
    end

    post('create order') do
      response(200, 'successful') do
        run_test!
      end

      response(400, 'No products in users basket') do
        run_test!
      end

      response(401, 'Unauthorized') do
        run_test!
      end

      response(500, 'Server error') do
        run_test!
      end
    end
  end

  path '/v1/users/{user_id}/orders/{id}' do
    # You'll want to customize the parameter types...
    parameter name: 'user_id', in: :path, type: :string, description: 'user_id'
    parameter name: 'id', in: :path, type: :string, description: 'id'

    get('show order') do
      response(200, 'successful') do
        run_test!
      end

      response(401, 'Unauthorized') do
        run_test!
      end
    end
  end
end
