require 'rails_helper'

RSpec.describe "Api::V1::Games", type: :request do
  describe "GET /api/v1/games" do
    it "retorna a lista de todos os jogos com status 200 OK" do
      get "/api/v1/games"

      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)

      expect(json).to be_a(Hash)
      expect(json).to have_key("game_1")
    end
  end

  describe "GET /api/v1/games/:id" do
    context "quando o jogo existe" do
      it "retorna os dados do jogo com status 200 OK" do
        get "/api/v1/games/game_1"

        expect(response).to have_http_status(:ok)
        json = JSON.parse(response.body)

        expect(json).to have_key("game_1")
        expect(json["game_1"]).to have_key("total_kills")
        expect(json["game_1"]).to have_key("players")
        expect(json["game_1"]).to have_key("kills")
      end
    end

    context "quando o jogo não existe" do
      it "retorna erro com status 404 Not Found" do
        get "/api/v1/games/game_999"

        expect(response).to have_http_status(:not_found)
        json = JSON.parse(response.body)

        expect(json).to eq({ "error" => "Jogo não encontrado" })
      end
    end
  end
end
