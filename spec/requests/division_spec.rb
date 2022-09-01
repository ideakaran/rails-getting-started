require 'rails_helper'

#todo reduce test duplication
RSpec.describe Api::V1::DivisionsController do
  describe '#update' do
    it 'creates new division' do
      user = create(:user)
      game = create(:game, user: user)
      token = JWT.encode({user_id: user.id}, 'secret')
      headers = { "Authorization" => "Bearer #{token}" }

      post '/api/v1/games/1/divisions', :params => {"name": "Champions Division"}, :headers => headers
      resp = JSON.parse(response.body)
      expect(response).to have_http_status(:created)
      expect(resp["game_id"]).to eq(game.id)
    end

    it 'cannot create new division without authorization header' do
      user = create(:user)
      create(:game, user: user)

      post '/api/v1/games/1/divisions', :params => {"name": "Champions Division"}
      expect(response).to have_http_status(:unauthorized)
    end
  end
end