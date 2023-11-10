require 'rails_helper'

RSpec.describe "Basket", type: :request do
    before(:each) do
        @user = FactoryGirl.create(:user, :with_order, :with_basket)
    end

    it "Gets all the users orders successfully" do
        get "/v1/users/#{@user.id}/orders", headers: { Authorization: @user.jwt }
        expect(response.status).to be(200)
        body = JSON.parse(response.body)
        expect(response.body["data"].present?).to be(true)
    end

    it "Gets all the users orders without being logged in" do
        get "/v1/users/#{@user.id}/orders"
        expect(response.status).to be(401)
        expect(response.body).to include('Unauthorized')
    end

    it "Creates an order from the users basket" do
        first_product = @user.basket.first
        post "/v1/users/#{@user.id}/orders", headers: { Authorization: @user.jwt }
        expect(response.status).to be(200)
    end

    it "Fails to create an order when the basket is empty" do
        @user.basket.destroy_all
        post "/v1/users/#{@user.id}/orders", headers: { Authorization: @user.jwt }
        expect(response.status).to be(400)
        expect(response.body).to include('No products in basket')
    end

    it "Fails to create an order when the user is not logged in" do
        post "/v1/users/#{@user.id}/orders"
        expect(response.status).to be(401)
        expect(response.body).to include('Unauthorized')
    end

    it "Gets a single order containing the orders products" do
        get "/v1/users/#{@user.id}/orders/#{@user.orders.first.id}", headers: { Authorization: @user.jwt }
        expect(response.status).to be(200)
        body = JSON.parse(response.body)
        expect(body["data"]["ordered_products"].empty?).to be(false)
    end

    it "Fails to get a single order when the user is not logged in" do
        get "/v1/users/#{@user.id}/orders/#{@user.orders.first.id}"
        expect(response.status).to be(401)
        expect(response.body).to include('Unauthorized')
    end
end