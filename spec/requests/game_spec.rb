require 'rails_helper'

#todo reduce test duplication
RSpec.describe Api::V1::GamesController do
  describe '#index' do
    it 'returns error without Authorization Code' do
      get '/api/v1/games'
      resp = JSON.parse(response.body)
      expect(response.status).to eq 401
      expect(resp["message"]).to eq("Operation Not Allowed")
    end

    it 'returns game when Authorization Header Is Provided' do
      user = create(:user)
      game = create(:game, user: user)
      token = JWT.encode({user_id: user.id}, 'secret')
      headers = { "Authorization" => "Bearer #{token}" }
      get '/api/v1/games', headers: headers
      resp = JSON.parse(response.body)
      expect(response).to have_http_status(:ok)
      expect(resp["status"]).to eq("SUCCESS")
      expect(resp["data"].length).to eq(1)
      expect(resp["message"]).to eq("All Games Loaded")
    end

    it 'shows all games created by different users to Admin' do
      user1 = create(:user, username: "user1", user_type: "regular", password: "test")
      user2 = create(:user, username: "user2", user_type: "regular", password: "test")
      adminUser = create(:user)
      game1 = create(:game, user: user1)
      game2 = create(:game, user: user2)

      token = JWT.encode({user_id: adminUser.id}, 'secret')
      headers = { "Authorization" => "Bearer #{token}" }
      get '/api/v1/games', headers: headers
      resp = JSON.parse(response.body)
      expect(response).to have_http_status(:ok)
      expect(resp["data"].length).to eq(2)
    end

    it 'shows only those game created by particular regular user' do
      user1 = create(:user, username: "user1", user_type: "regular", password: "test")
      user2 = create(:user, username: "user2", user_type: "regular", password: "test")
      game1 = create(:game, user: user1)
      game2 = create(:game, user: user2)

      token = JWT.encode({user_id: user1.id}, 'secret')
      headers = { "Authorization" => "Bearer #{token}" }
      get '/api/v1/games', headers: headers
      resp = JSON.parse(response.body)
      expect(response).to have_http_status(:ok)
      expect(resp["data"].length).to eq(1)
    end
  end
end