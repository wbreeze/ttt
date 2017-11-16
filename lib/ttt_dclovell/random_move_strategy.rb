module TttDclovell
  # Generate a move at random
  # This is not a very smart tic tac toe player
  class RandomMoveStrategy
    def initialize(seed = nil)
      seed ||= Random.new_seed
      @rand = Random.new(seed)
    end

    def generate_move(board)
      p = @rand.rand(9)
      # rubocop: disable Style/MultilineIfModifier, Style/WhileUntilModifier
      until board.get(row(p), col(p)) == :n
        p = (p + 1) % 9
      end unless board.complete?
      { :token => :pos, row: row(p), col: col(p) }
    end

    private

    def row(i)
      i / 3
    end

    def col(i)
      i % 3
    end
  end
end
