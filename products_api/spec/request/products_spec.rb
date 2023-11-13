require 'rails_helper'

RSpec.describe "Products", type: :request do
    before(:each) do
        @apikey = FactoryGirl.create(:apikey)
    end

    it "gets all the products successfully" do
        user = FactoryGirl.create(:user)
        get "/v1/products", headers: { Authorization: user.jwt, "x-api-key": @apikey.key }
        expect(response.status).to be(200)
    end

    it "gets all the products without a token, and fails" do
        get "/v1/products"
        expect(response.status).to be(401)
        expect(response.body).to include('Unauthorized')
    end
end