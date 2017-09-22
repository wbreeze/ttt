class BoardPretty

  attr_accessor :row_labels, :col_labels
  PLACE_LABELS = {
    x: 'X',
    o: 'O',
    n: ' '
  }

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

  ###
  private
  ###

  def draw_col_labels
    l = '     '
    col_labels.each { |c| l << (" #{c}  ") }
    return l
  end

  def draw_separator
    '    +---+---+---+'
  end

  def draw_row(board, r)
    label = r
    if (0 <= r && r < row_labels.length)
      label = row_labels[r]
    end
    l = " #{label}  |"
    (0..2).each { |c| l << " #{PLACE_LABELS[board.get(r,c)]} |" }
    return l
  end
end
