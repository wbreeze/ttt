class MasterController
  def initialize(interact = nil)
    @gs = GameState.new_game(self)
    @interact = interact || TerminalInteractor.new
    @board = GameBoard.new
    @computer_strategy = RandomMoveStrategy.new
  end

  # entry point for game play
  def play
    while advance_game_state
    end
  end

  def get_moving(role)
    @move_generator = nil
    if (role == :first_mover)
      @move_generator = PlayerIsX.new(@computer_strategy, @interact, @board)
    elsif (role == :second_mover)
      @move_generator = PlayerIsO.new(@computer_strategy, @interact, @board)
    elsif (role == :bye)
      @gs.bye
    end
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
      @interact.move_not_valid
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
    @interact.announce_result(@board)
    @board.reset
  end

  def finish
    @interact.goodbye
  end

  ###
  private
  ###

  # play a move
  def advance_game_state
    playing = true
    case @gs.current
    when :limbo
      role = @interact.get_player_role_preference
      @gs.role_selected(role)
    when :start, :saw_o
      move = @move_generator.get_X_move
      tkn = move[:token]
      if (tkn == :pos)
        @gs.x_placed(move[:row], move[:col])
      else
        @gs.bye
      end
    when :saw_x
      move = @move_generator.get_O_move
      tkn = move[:token]
      if (tkn == :pos)
        @gs.o_placed(move[:row], move[:col])
      else
        @gs.bye
      end
    when :finish
      playing = false
    else
      playing = false
    end
    return playing
  end
end
