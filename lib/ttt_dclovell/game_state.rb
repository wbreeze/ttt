require 'finite_machine'

module TttDclovell
  # GameState is a factory class
  # Calling `new_game` will make a state machine for the game
  # The object returned by `new_game` is a FiniteMachine
  # https://github.com/peter-murach/finite_machine#7-stand-alone-finitemachine
  # rubocop:disable Metrics/AbcSize, Metrics/BlockLength, Metrics/MethodLength
  class GameState
    def self.new_game(mc, state = :limbo)
      FiniteMachine.define do
        target mc
        initial state

        events do
          event :role_selected, :limbo => :start
          event :x_placed, [:start, :saw_o] => :saw_x,
            if: ->(_, row, col) { target.check_and_play(:x, row, col) }
          event :o_placed, :saw_x => :saw_o,
            if: ->(_, row, col) { target.check_and_play(:y, row, col) }
          event :game_complete, [:saw_x, :saw_o] => :limbo
          event :bye, :any => :finish
        end

        callbacks do
          on_transition(:start) { |_, role| target.get_moving(role) }
          on_transition(:saw_x) { target.check_game_state }
          on_transition(:saw_o) { target.check_game_state }
          on_transition(:limbo) { target.game_over }
          on_transition(:finish) { target.finish }
        end

        handlers do
          handle FiniteMachine::InvalidStateError do |exception|
            target.apply_exception(exception)
          end
          handle FiniteMachine::InvalidEventError do |exception|
            target.apply_exception(exception)
          end
          handle FiniteMachine::TransitionError do |exception|
            target.apply_exception(exception)
          end
        end
      end
    end
  end
end
