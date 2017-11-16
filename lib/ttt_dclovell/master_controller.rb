require 'ttt_dclovell/game_board'
require 'ttt_dclovell/game_state'
require 'ttt_dclovell/player_provider'
require 'ttt_dclovell/random_move_strategy'
require 'ttt_dclovell/terminal_interactor'

module TttDclovell
  # Coordinate activity of game_state and game_board
  # along with interactions for two players
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
      if role == :first_mover
        @move_generator = PlayerIsX.new(@computer_strategy, @interact, @board)
      elsif role == :second_mover
        @move_generator = PlayerIsO.new(@computer_strategy, @interact, @board)
      elsif role == :bye
        @gs.bye
      end
    end

    def check_and_play(role, row, col)
      if @board.get(row, col) == :n
        if role == :x
          @board.set_x(row, col)
        else
          @board.set_o(row, col)
        end
        true
      else
        @interact.move_not_valid
        false
      end
    end

    def check_game_state
      @gs.game_complete if @board.complete?
    end

    def game_over
      @interact.announce_result(@board)
      @board.reset
    end

    def finish
      @interact.goodbye
    end

    private

    # play a move
    def advance_game_state
      playing = true
      case @gs.current
      when :limbo
        role = @interact.get_player_role_preference
        @gs.role_selected(role)
      when :start, :saw_o
        make_x_move
      when :saw_x
        make_o_move
      when :finish
        playing = false
      else
        playing = false
      end
      playing
    end

    def make_x_move
      move = @move_generator.get_X_move
      tkn = move[:token]
      if tkn == :pos
        @gs.x_placed(move[:row], move[:col])
      else
        @gs.bye
      end
    end

    def make_o_move
      move = @move_generator.get_O_move
      tkn = move[:token]
      if tkn == :pos
        @gs.o_placed(move[:row], move[:col])
      else
        @gs.bye
      end
    end
  end
end
