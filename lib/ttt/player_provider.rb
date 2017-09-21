class PlayerProvider
  def initialize(computer_strategy)
    @computer_strategy = computer_strategy
  end

  def generate_next_move
    return {row:0, col:0}
  end

  def prompt_and_parse
    return {row:1, col:1}
  end
end

class PlayerIsO < PlayerProvider
  def initialize(computer_strategy)
    super(computer_strategy)
  end

  def get_X_move
    generate_next_move
  end

  def get_O_move
    prompt_and_parse
  end
end

class PlayerIsX < PlayerProvider
  def initialize(computer_strategy)
    super(computer_strategy)
  end

  def get_X_move
    prompt_and_parse
  end

  def get_O_move
    generate_next_move
  end
end
