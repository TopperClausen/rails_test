require 'rails_helper'

RSpec.describe "Users", type: :request do
    before(:each) do
        @apikey = FactoryGirl.create(:apikey)
    end

    it "tries to log a user in successfully" do
        user = User.create(full_name: 'Torben Jensen', email: 'test@test.dk', password: 'SecretMagicWord123')
        post "/v1/sessions", params: { email: user.email, password: user.password }, headers: { "x-api-key": @apikey.key }
        expect(response.body).to include('jwt')
    end

    it "logs a user in, with a wrong email" do
        user = User.create(full_name: 'Torben Jensen', email: 'test@test.dk', password: 'SecretMagicWord123')
        wrong_email = "wrong@email.dk"
        post "/v1/sessions", params: { email: wrong_email, password: user.password }, headers: { "x-api-key": @apikey.key }
        expect(response.body).not_to include('jwt')
        expect(response.status).to be(401)
    end

    it "logs a user in, with a wrong password" do
        user = User.create(full_name: 'Torben Jensen', email: 'test@test.dk', password: 'SecretMagicWord123')
        wrong_password = "WrongPassword123"
        post "/v1/sessions", params: { email: user.email, password: wrong_password }, headers: { "x-api-key": @apikey.key }
        expect(response.body).not_to include('jwt')
        expect(response.status).to be(401)
    end
end