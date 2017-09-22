class MasterController
  def initialize(interact = nil)
    @interact = interact || TerminalInteractor.new
    @board = GameBoard.new
    @gs = GameState.new_game(self)
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

  def check_and_play(role, row, col)
    valid = true
    if @board.get(row, col) == :n
      if role == :x
        @board.set_x(row, col)
      else
        @board.set_o(row, col)
      end
    else
      valid = false
    end
    return valid
  end

  def check_game_state
    if @board.is_complete
      @gs.game_complete
    end
  end

  def game_over
    @interact.announce_result
  end

  ###
  private
  ###

  # start one game
  def start_game(strategy)
    play = true
    move_generator = nil
    role = @interact.get_player_role_preference
    if (role == :first_mover)
      move_generator = PlayerIsX.new(strategy, @interact)
    elsif (role == :second_mover)
      move_generator = PlayerIsO.new(strategy, @interact)
    else
      play = false
    end
    if play
      play = play_the_game(move_generator)
    end
    play
  end

  # game running with selected move generator
  def play_the_game(move_generator)
    @gs.restore!(:start)
    @board.reset
    playing = true
    while playing
      playing = advance_game_state(move_generator)
    end
    @interact.thank_partner
    @interact.did_quit
  end

  # play a move
  def advance_game_state(move_generator)
    playing = true
    case @gs.current
    when :start, :saw_o
      move = move_generator.get_X_move
      tkn = move[:token]
      if (tkn == :pos)
        @gs.x_placed(move[:row], move[:col])
      else
        playing = false
      end
    when :saw_x
      move = move_generator.get_O_move
      tkn = move[:token]
      if (tkn == :pos)
        @gs.o_placed(move[:row], move[:col])
      else
        playing = false
      end
    when :finish
      playing = false
    else
      playing = false
    end
    playing
  end
end
