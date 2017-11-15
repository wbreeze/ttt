module TttDclovell
  class RandomMoveStrategy
    def initialize(seed = nil)
      seed ||= Random.new_seed
      @rand = Random.new(seed)
    end

    def generate_move(board)
      p = @rand.rand(9)
      until (:n == board.get(row(p), col(p)))
        p = (p + 1) % 9
      end unless board.is_complete
      return { :token => :pos, row: row(p), col: col(p) }
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
