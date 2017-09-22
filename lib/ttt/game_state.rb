require 'finite_machine'

# GameState is a factory class
# Calling `new_game` will make a state machine for the game
# The object returned by `new_game` is a FiniteMachine
# https://github.com/peter-murach/finite_machine#7-stand-alone-finitemachine
class GameState
  def self.new_game(mc, state = :start)
    FiniteMachine.define do
      target mc
      initial state

      events {
        event :x_placed, [:start, :saw_o] => :saw_x
        event :o_placed, :saw_x => :saw_o
        event :game_complete, [:saw_x, :saw_o] => :finish
      }

      callbacks {
        # we use on_before for things that could cancel the transition
        #   failure to process a payment is an example
        # we use on_after for things that must happen when the transition
        #   has occurred
        on_before(:x_placed) { |event, row, col| target.check_and_play(:x, row, col) }
        on_before(:o_placed) { |event, row, col| target.check_and_play(:o, row, col) }
        on_transition(:saw_x) { |event| target.check_game_state }
        on_transition(:saw_o) { |event| target.check_game_state }
        on_transition(:finish) { |event| target.game_over }
      }

      handlers {
        handle FiniteMachine::InvalidStateError do |exception|
          target.apply_exception(exception)
        end
        handle FiniteMachine::InvalidEventError do |exception|
          target.apply_exception(exception)
        end
        handle FiniteMachine::TransitionError do |exception|
          target.apply_exception(exception)
        end
      }
    end
  end
end
