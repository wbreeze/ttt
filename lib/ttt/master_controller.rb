class MasterController
  def initialize(interact = nil)
    @interact = interact || TerminalInteractor.new
  end

  # entry point for game play
  def play
    computer_strategy = RandomMoveStrategy.new
    playing = true
    while playing
      playing = start_game(computer_strategy)
    end
    @interact.goodbye
  end

  # start one game
  def start_game(strategy)
    continue = true
    move_generator = nil
    role = @interact.get_player_role_preference
    if (role == :first_mover)
      move_generator = PlayerIsX.new(strategy)
    elsif (role == :second_mover)
      move_generator = PlayerIsO.new(strategy)
    else
      continue = false
    end
    if continue
      continue = play_the_game(move_generator)
    end
    continue
  end

  # game running with selected move generator
  def play_the_game(move_generator)
    gs = GameState.new_game(self)
    @board = GameBoard.new
    playing = true
    while playing
      playing = false
    end
    @interact.thank_partner
    @interact.did_quit
  end
end
