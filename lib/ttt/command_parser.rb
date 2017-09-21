class CommandParser
  INVALID_POSITION = -1

  attr_reader :row, :col

  def initialize
    reset_pos
  end

  def reset_pos
    @row = INVALID_POSITION
    @col = INVALID_POSITION
  end

  def parse(ui)
    reset_pos
    ui.strip!
    case ui
    when /^(h|help)$/i
      :help
    when /^x$/i
      :be_x
    when /^y$/i
      :be_y
    when /^yes$/i
      :yes
    when /^no?$/i
      :no
    when /^(bye|exit|quit|q|done|uncle|ciao|cha[ou])$/i
      :bye
    when /^([abc])\s*([123])$/i
      parse_pos_match(Regexp.last_match)
      :pos
    else
      :unrecognized
    end
  end

  ###
  private
  ###

  def parse_row(row_s)
    rv = row_s.to_i - 1
    @row = if (0 <= rv && rv <= 2)
      rv
    else
      INVALID_POSITION
    end
    @row != INVALID_POSITION
  end

  def parse_col(col_s)
    @col = case col_s[0].upcase
    when 'A'
      0
    when 'B'
      1
    when 'C'
      2
    else
      INVALID_POSITION
    end
    @col != INVALID_POSITION
  end

  def parse_pos_match(match)
    parse_col(match[1]) && parse_row(match[2])
  end
end
