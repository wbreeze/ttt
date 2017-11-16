require 'json'

module TttDclovell
  # Model the Tic Tac Toe game board
  class GameBoard
    def initialize
      @state = Array.new(9)
      reset
    end

    def reset
      @state.fill(:n)
    end

    def get(row, col)
      @state[pos(row, col)]
    end

    def set_o(row, col)
      @state[pos(row, col)] = :o
    end

    def set_x(row, col)
      @state[pos(row, col)] = :x
    end

    def clear(row, col)
      @state[pos(row, col)] = :n
    end

    def complete?
      [:draw, :win_x, :win_o].include? state
    end

    def state
      if win_x?
        :win_x
      elsif win_o?
        :win_o
      elsif full?
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
      JSON.fast_generate(game_state: pretty)
    end

    private

    def pos(row, col)
      row * 3 + col
    end

    def win?(xo)
      wp = [
        [0, 3, 6], [1, 4, 7], [2, 5, 8],
        [0, 1, 2], [3, 4, 5], [6, 7, 8],
        [0, 4, 8], [2, 4, 6]
      ].find do |line|
        line.reduce(true) do |m, p|
          m && (@state[p] == xo)
        end
      end
      !wp.nil?
    end

    def win_x?
      win?(:x)
    end

    def win_o?
      win?(:o)
    end

    def full?
      @state.inject(true) do |m, v|
        m && (v != :n)
      end
    end
  end
end
