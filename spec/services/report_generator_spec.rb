require 'rails_helper'

RSpec.describe ReportGenerator, type: :service do
  let(:log_file_path) { Rails.root.join('spec', 'fixtures', 'games.log') }
  let(:games) { LogParser.new(log_file_path).parse }
  subject(:generator) { described_class.new(games) }

  describe '#generate_games_report' do
    it 'retorna um Hash com o relatório agrupado por partida' do
      report = generator.generate_games_report

      expect(report).to be_a(Hash)
      expect(report).to have_key('game_1')
      expect(report['game_1']).to be_a(Hash)
      expect(report['game_1']).to have_key(:total_kills)
      expect(report['game_1']).to have_key(:players)
      expect(report['game_1']).to have_key(:kills)
    end
  end

  describe '#generate_global_ranking' do
    it 'retorna um Hash com a soma total de kills por jogador' do
      ranking = generator.generate_global_ranking

      expect(ranking).to be_a(Hash)
      expect(ranking).to have_key('Isgalamido')
    end

    it 'ordena os jogadores do maior para o menor pontuador' do
      ranking = generator.generate_global_ranking
      scores = ranking.values

      expect(scores).to eq(scores.sort.reverse)
    end
  end
end