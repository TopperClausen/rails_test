require 'rails_helper'

RSpec.describe "Users", type: :request do
    it "creates a user, successfully" do
        post "/users", params: { full_name: 'Jørgen Jørgnsen', email: "jørgen2@test.com", password: "SecretMagicWord123" }
        expect(response.body).to include('success')
    end

    it "creates a user with an email in use" do
        email = 'test@test.dk'
        User.create(email: email, full_name: 'Test Test', password: 'MagicWord123')
        post "/users", params: { full_name: 'Jørgen Jørgnsen', email: email, password: "SecretMagicWord123" }
        expect(response.body).to include('has already been taken')
    end

    it "creates a user with a password in less than 6 characters" do
        post "/users", params: { full_name: 'Jørgen Jørgnsen', email: 'test@test.com', password: "12345" }
        expect(response.body).to include('is too short (minimum is 6 characters)')
    end
end