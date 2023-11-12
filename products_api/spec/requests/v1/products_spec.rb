require 'swagger_helper'

RSpec.describe 'v1/products', type: :request do

  path '/v1/products' do

    parameter name: 'Authorization', in: :header, type: :string, description: 'Token received from login', required: true

    get('list products') do
      response(200, 'successful') do
        run_test!
      end

      response(401, 'Unauthorized') do
        run_test!
      end
    end
  end
end
