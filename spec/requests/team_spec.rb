require 'rails_helper'

#todo reduce test duplication
RSpec.describe Api::V1::TeamsController do
  describe '#update' do
    it 'can post new team' do
      user = create(:user)
      game = create(:game, user: user)
      create(:division, game_id: game.id, user: user)
      token = JWT.encode({user_id: user.id}, 'secret')
      headers = { "Authorization" => "Bearer #{token}" }

      post '/api/v1/games/1/divisions/1/teams', :params => {"name": "TeamArsenal", "managerName": "Mikel Arteta", "managerContact": "020761"}, :headers => headers

      resp = JSON.parse(response.body)
      expect(response).to have_http_status(:created)
      expect(resp["name"]).to eq("TeamArsenal")
      expect(resp["managerName"]).to eq("Mikel Arteta")
    end

    it 'cannot post new team without authorization header' do
      user = create(:user)
      create(:game, user: user)

      post '/api/v1/games/1/divisions/1/teams', :params => {"name": "Arsenal", "managerName": "Mikel Arteta", "managerContact": "020761"}

      expect(response).to have_http_status(:unauthorized)
    end
  end
end