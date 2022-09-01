require 'rails_helper'

RSpec.describe Api::V1::UsersController do
  describe '#show' do
    it 'creates a user' do
      post '/api/v1/users', params: {"username": "testuser", "password": "pass123", "user_type": "regular"}
      res = JSON.parse(response.body)
      expect(response.status).to eq(200)
      expect(res["token"]).to start_with("eyJ")
    end

    it 'returns a user' do
      create(:user)
      get '/api/v1/users/1'
      res = JSON.parse(response.body)
      expect(response.status).to eq(200)
      expect(res["username"]).to eq("karan")
      expect(res["user_type"]).to eq("admin")
    end
  end
end