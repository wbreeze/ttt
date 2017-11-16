require 'ttt_dclovell/version'
require 'ttt_dclovell/master_controller'

module TttDclovell
  # Play the game of Tic Tac Toe
  class TicTacToe
    def self.play
      controller = MasterController.new
      controller.play
    end
  end
end
