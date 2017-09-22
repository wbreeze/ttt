class TerminalInteractor

  attr_accessor :input, :output
  attr_reader :did_quit

  def initialize(input = $stdin, output = $stdout)
    self.input = input
    self.output = output
    @cp = CommandParser.new
    @board_display = BoardPretty.new(@cp.row_labels, @cp.col_labels)
    @did_quit = false
  end

  def get_player_role_preference
    tkn = get_response('Which player do you want to be? X or O?', [:be_x, :be_o])
    return case tkn
    when :be_x
      :first_mover
    when :be_o
      :second_mover
    else
      tkn
    end
  end

  def get_player_move(board)
    output.puts "\n#{@board_display.render_text(board)}\n"
    tkn = get_response('Where do you want to move?', [:pos])
    return { token: tkn, row: @cp.row, col: @cp.col }
  end

  def announce_result(board)
    output.puts @board_display.render_text(board)
    case board.state
    when :win_x
      output.puts 'X has won!'
    when :win_o
      output.puts 'O has won!'
    when :draw
      output.puts 'That was a draw.'
    end
  end

  def move_not_valid
    output.puts('You can\'t move there.')
  end

  def thank_partner
    output.puts('Thank you for playing!')
  end

  def goodbye
    output.puts('Bye for now!')
  end

  ###
  private
  ###

  # repeat the prompt and response until valid token or exit
  # sets did_quit
  def get_response(prompt, valid_tokens)
    @did_quit = false
    valid = false
    until valid
      output.puts(prompt)
      resp = input.gets
      tkn = @cp.parse(resp)
      valid = valid_tokens.include? tkn
      unless valid
        if tkn == :help
          output.puts(@cp.help_text)
        elsif tkn == :bye
          valid = true
          @did_quit = true
        else
          output.puts("Type 'h' and press enter for help.\n")
        end
      end
    end
    return tkn
  end
end
