class Api::V1::ReportsController < ApplicationController

  before_action :load_reports

  def global_ranking
    render json: { ranking_global: @global_ranking }, status: :ok
  end

  private 

  def load_reports
    parser = LogParser.new
    games = parser.parse
    generator = ReportGenerator.new(games)

    @global_ranking = generator.generate_global_ranking
  end

end
