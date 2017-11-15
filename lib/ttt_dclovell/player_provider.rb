module TttDclovell
  class PlayerProvider
    def initialize(computer_strategy, interact, board)
      @computer_strategy = computer_strategy
      @player = interact
      @board = board
    end

    def generate_next_move
      @computer_strategy.generate_move(@board)
    end

    def prompt_and_parse
      @player.get_player_move(@board)
    end
  end

  class PlayerIsO < PlayerProvider
    def initialize(computer_strategy, interact, board)
      super(computer_strategy, interact, board)
    end

    def get_X_move
      generate_next_move
    end

    def get_O_move
      prompt_and_parse
    end
  end

  class PlayerIsX < PlayerProvider
    def initialize(computer_strategy, interact, board)
      super(computer_strategy, interact, board)
    end

    def get_X_move
      prompt_and_parse
    end

    def get_O_move
      generate_next_move
    end
  end
end
