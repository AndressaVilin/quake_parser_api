# guarda as informaçoes de um jogo especifico e calcular as regras de pontuação

class Game
  attr_reader :id, :total_kills, :players, :kills

  def initialize(id)
    @id = id
    @total_kills = 0
    @players = []
    @kills = Hash.new(0)
  end

  def add_player(player_name)
    return if player_name == "<world>" || @players.include?(player_name)

    @players << player_name
    @kills[player_name] ||= 0
  end

  def record_kill(killer, victim)
    @total_kills += 1

    add_player(victim)

    if killer == "<world>"
      @kills[victim] -= 1
    else
      add_player(killer)
      @kills[killer] += 1
    end
  end

  def to_h
    {
      "game_#{@id}" => {
        total_kills: @total_kills,
        players: @players,
        kills: @kills
      }
    }
  end
end
