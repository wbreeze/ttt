class CommandParser
  INVALID_POSITION = -1

  attr_reader :pos

  def initialize
    reset_pos
  end

  def reset_pos
    @pos = INVALID_POSITION
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

  def parse_pos_match(match)
    col = match[1]
    cv = -1
    case col[0].upcase
    when 'A'
      cv = 0
    when 'B'
      cv = 1
    when 'C'
      cv = 2
    end

    row = match[2]
    rv = row.to_i - 1

    if (0 <= cv && cv <= 2 && 0 <= rv && rv <= 2)
      @pos = rv * 3 + cv
    else
      @pos = INVALID_POSITION
    end
  end
end
