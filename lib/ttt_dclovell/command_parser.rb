module TttDclovell
  # Translate command line input into tokens
  # (It's actually a Lexer, not a Parser)
  # rubocop:disable Metrics/MethodLength
  class CommandParser
    attr_reader :row, :col

    INVALID_POSITION = -1

    def initialize
      reset_pos
    end

    def help_text
      <<-HELP
  The program will keep playing until you ask to stop.
  Type 'q' or 'exit' or 'bye' at any time to get out.

  Type 'x' when prompted, to be the first to move.
  Type 'o' when prompted, to be the second to move.
  Type 'y' when prompted, to say "yes".
  Type 'n' when prompted, to say "no".

  Type a "position", when prompted, to move.
     A position looks like, 'B2'.
       The 'B' is the column label.
       The '2' is the row label.
       'B2' is the center.
     More examples of valid positions that you can type:
       'A1' is the top left corner.
       'C3' is the bottom right corner.
       'A2' is the left side of the middle row.

  If the computer doesn't understand you, it will repeat the question.
  You can always type 'h' to get this help.
  You can always type 'q' to quit or exit, stop, leave.
      HELP
    end

    def reset_pos
      @row = INVALID_POSITION
      @col = INVALID_POSITION
    end

    # rubocop:disable Metrics/CyclomaticComplexity
    def parse(ui)
      reset_pos
      ui.strip!
      case ui
      when /^(h|help)$/i
        :help
      when /^x$/i
        :be_x
      when /^o$/i
        :be_o
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

    def row_labels
      %w[1 2 3]
    end

    def col_labels
      %w[A B C]
    end

    private

    def parse_row(row_s)
      @row = row_labels.index(row_s[0].upcase)
      @row ||= INVALID_POSITION
    end

    def parse_col(col_s)
      @col = col_labels.index(col_s[0].upcase)
      @col ||= INVALID_POSITION
    end

    def parse_pos_match(match)
      parse_col(match[1]) && parse_row(match[2])
    end
  end
end
