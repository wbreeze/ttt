class PlayerProvider
  def initialize(computer_strategy, interact)
    @computer_strategy = computer_strategy
    @player = interact
  end

  def generate_next_move
    @computer_strategy.generate_move
  end

  def prompt_and_parse
    @player.get_player_move
  end
end

class PlayerIsO < PlayerProvider
  def initialize(computer_strategy, interact)
    super(computer_strategy, interact)
  end

  def get_X_move
    generate_next_move
  end

  def get_O_move
    prompt_and_parse
  end
end

class PlayerIsX < PlayerProvider
  def initialize(computer_strategy, interact)
    super(computer_strategy, interact)
  end

  def get_X_move
    prompt_and_parse
  end

  def get_O_move
    generate_next_move
  end
end
