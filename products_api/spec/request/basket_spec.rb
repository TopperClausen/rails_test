require 'rails_helper'

RSpec.describe "Basket", type: :request do
    before(:each) do
        @apikey = FactoryGirl.create(:apikey)
        @user = FactoryGirl.create(:user, :with_basket)
    end

    it "gets all the products in a users basket successfully" do
        get "/v1/users/#{@user.id}/baskets", headers: { Authorization: @user.jwt, "x-api-key": @apikey.key }
        expect(response.status).to be(200)
        expect(response.body).to include(@user.basket.first.name)
    end

    it "Attempts to get a basket without being logged in as the correct user" do
        logged_in_user = FactoryGirl.create(:user)
        get "/v1/users/#{@user.id}/baskets", headers: { Authorization: logged_in_user.jwt, "x-api-key": @apikey.key }
        expect(response.status).to be(401)
        expect(response.body).to include("Unauthorized")
    end

    it "Attempts to get a basket without being logged in" do
        get "/v1/users/#{@user.id}/baskets"
        expect(response.status).to be(401)
        expect(response.body).to include("Unauthorized")
    end

    it "Updates the amount of a product in the basket successfully" do
        product = @user.basket.first
        amount = 10
        put "/v1/users/#{@user.id}/baskets", params: { product_id: product.id, amount: amount }, headers: { Authorization: @user.jwt, "x-api-key": @apikey.key }
        body = JSON.parse(response.body)
        expect(body["data"].first["amount"]).to be(amount)
    end

    it "Removes an item from the basket" do
        product = @user.basket.first
        amount = 0
        put "/v1/users/#{@user.id}/baskets", params: { product_id: product.id, amount: amount }, headers: { Authorization: @user.jwt, "x-api-key": @apikey.key }
        body = JSON.parse(response.body)
        expect(body["data"].empty?).to be(true)
        expect(@user.basket_product.where.not(amount: 0).empty?).to be(true)
    end

    it "Attempts to update a basket without being logged in" do
        put "/v1/users/#{@user.id}/baskets"
        expect(response.status).to be(401)
        expect(response.body).to include("Unauthorized")
    end

    it "Clears the basket" do
        delete "/v1/users/#{@user.id}/baskets", headers: { Authorization: @user.jwt, "x-api-key": @apikey.key }
        expect(@user.basket.blank?).to be(true)
    end
end