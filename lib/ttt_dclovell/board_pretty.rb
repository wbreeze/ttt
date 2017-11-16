module TttDclovell
  # Draw the Tic Tac Toe board
  class BoardPretty
    attr_accessor :row_labels, :col_labels

    PLACE_LABELS = {
      x: 'X',
      o: 'O',
      n: ' '
    }.freeze

    def initialize(rlabels = [], clabels = [])
      @row_labels = rlabels
      @col_labels = clabels
    end

    def render_text(board)
      d = []
      d << draw_col_labels
      d << draw_separator
      (0..2).each do |r|
        d << draw_row(board, r)
        d << draw_separator
      end
      d << ''
      d.join("\n")
    end

    private

    def draw_col_labels
      line = '        '
      col_labels.each { |c| line << " #{c}  " }
      line
    end

    def draw_separator
      '       +---+---+---+'
    end

    def draw_row(board, r)
      label = (0 <= r && r < row_labels.length) ? row_labels[r] : r
      line = "    #{label}  |"
      (0..2).each { |c| line << " #{PLACE_LABELS[board.get(r, c)]} |" }
      line
    end
  end
end
