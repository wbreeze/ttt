require 'ttt_dclovell/version'
require 'ttt_dclovell/master_controller'

module TttDclovell
  class TicTacToe
    def self.play
      controller = MasterController.new
      controller.play
    end
  end
end
