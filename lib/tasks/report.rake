namespace :report do
  desc "Gera e imprime o relatorio dos jogos e o ranking geral de kills"
  task generate: :environment do
    log_path = Rails.root.join("storage", "games.log")

    parser = LogParser.new(log_path)
    games = parser.parse
    generator = ReportGenerator.new(games)

    puts "========================================"
    puts "      RELATÓRIO INDIVIDUAL DOS JOGOS    "
    puts "========================================"

    generator.generate_games_report.each do |game_id, data|
      puts "#{game_id.upcase}"
      puts "   • Total de Kills: #{data[:total_kills]}"
      puts "   • Jogadores: #{data[:players].empty? ? 'Nenhum' : data[:players].join(', ')}"

      if data[:kills].empty?
        puts "   • Kills: Nenhum registro"
      else
        puts "   • Kills por Jogador:"
        data[:kills].each do |player, kills|
          puts "     - #{player}: #{kills}"
        end
      end
    end

    puts "\n" + ("=" * 40) + "\n"

    puts "========================================"
    puts "       RANKING GLOBAL DE KILLS          "
    puts "========================================"

    generator.generate_global_ranking.each_with_index do |(player, kills), index|
      puts "#{index + 1}. #{player.ljust(15)} | #{kills} kills"
    end

    puts "========================================"
  end
end
