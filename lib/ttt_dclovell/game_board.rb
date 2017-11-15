require 'json'

module TttDclovell
  class GameBoard
    def initialize
      @state = Array.new(9)
      reset
    end

    def reset
      @state.fill(:n)
    end

    def get(row, col)
      @state[pos(row,col)]
    end

    def set_o(row,col)
      @state[pos(row,col)] = :o
    end

    def set_x(row,col)
      @state[pos(row,col)] = :x
    end

    def clear(row,col)
      @state[pos(row,col)] = :n
    end

    def is_complete
      [:draw, :win_x, :win_o].include? state
    end

    def state
      if has_win_x
        :win_x
      elsif has_win_o
        :win_o
      elsif is_full
        :draw
      else
        :incomplete
      end
    end

    def to_json
      pretty = @state.map do |p|
        case p
        when :x
          'x'
        when :o
          'o'
        else
          ' '
        end
      end
      JSON.fast_generate({ game_state: pretty })
    end

    private

    def pos(row, col)
      row * 3 + col
    end

    def has_win(xo)
      wp = [[0,3,6],[1,4,7],[2,5,8],
       [0,1,2],[3,4,5],[6,7,8],
       [0,4,8],[2,4,6]
      ].find do |line|
        line.reduce(true) do |m, p|
          m && (@state[p] == xo)
        end
      end
      !wp.nil?
    end

    def has_win_x
      has_win(:x)
    end

    def has_win_o
      has_win(:o)
    end

    def is_full
      @state.inject(true) do |m, v|
        m && (v != :n)
      end
    end
  end
end
