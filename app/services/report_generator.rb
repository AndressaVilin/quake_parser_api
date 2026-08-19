class ReportGenerator
  def initialize(games)
    @games = games
  end

  def generate_games_report
    report = {}

    @games.each do |game|
      report.merge!(game.to_h)
    end

    report
  end

  def generate_global_ranking
    ranking = Hash.new(0)

    @games.each do |game|
      game.kills.each do |player, kills_count|
          ranking[player] += kills_count
      end
    end

    ranking.sort_by { |_player, kills| -kills }.to_h
  end
end
