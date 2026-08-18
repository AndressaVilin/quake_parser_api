class LogParser

  KILL_REGEX = /Kill: \d+ \d+ \d+: (.+) killed (.+) by (.+)/

  def initialize(file_path = Rails.root.join('games.log'))
    @file_path = file_path
    @games = []
  end

  def parse 
    current_game = nil
    game_counter = 0

    File.foreach(@file_path) do |line|

      if line.include?('InitGame:')
        game_counter += 1
        current_game = Game.new(game_counter)
        @games << current_game
      end

      next unless current_game

      if line.include?('Kill:')
        match = line.match(KILL_REGEX)
        if match 
          killer = match[1].strip
          victim = match[2].strip
          current_game.record_kill(killer, victim)
        end
      end
    end
    
    @games
  end
end