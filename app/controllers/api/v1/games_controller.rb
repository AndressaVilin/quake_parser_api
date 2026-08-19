class Api::V1::GamesController < ApplicationController
  before_action :load_reports

  def index
    render json: @games_report, status: :ok
  end

  def show
    game = @games_report[params[:id]]

    if game
      render json: { params[:id] => game }, status: :ok
    else
      render json: { error: "Jogo não encontrado" }, status: :not_found
    end
  end

  private

  def load_reports
    parser = LogParser.new
    games = parser.parse
    generator = ReportGenerator.new(games)

    @games_report = generator.generate_games_report
  end
end
