require 'rails_helper'

RSpec.describe "Api::V1::Reports", type: :request do
  describe "GET /api/v1/reports/global_ranking" do
    it "retorna o ranking global de mortes com status 200 OK" do
      get "/api/v1/reports/global_ranking"

      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)

      expect(json).to have_key("ranking_global")
      expect(json["ranking_global"]).to be_a(Hash)
      expect(json["ranking_global"]).to have_key("Isgalamido")
    end
  end
end