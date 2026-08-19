require 'rails_helper'

RSpec.describe LogParser, type: :service do
  let(:log_file_path) { Rails.root.join('storage', 'games.log') }
  subject(:parser) { described_class.new(log_file_path) }

  describe '#parse' do
    it 'retorna uma Array com os jogos parseados' do
      games = parser.parse

      expect(games).to be_an(Array)
      expect(games).not_to be_empty
    end

    it 'instancia objetos Game dentro da lista' do
      games = parser.parse

      expect(games.first).to respond_to(:total_kills, :players, :kills)
    end
  end
end
