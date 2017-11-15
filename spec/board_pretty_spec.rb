RSpec.describe TttDclovell::BoardPretty do
  before :each do
    @board = TttDclovell::GameBoard.new
    @labels = {
      row: ['1', '2', '3'],
      col: ['A', 'B', 'C']
    }
    @display = TttDclovell::BoardPretty.new(@labels[:row], @labels[:col])
  end

  it 'can display an empty board' do
    text = @display.render_text(@board)
    expect(text).to match(/      A   B   C/)
    expect(text).to match(/ 1  |   |   |   |/)
    expect(text).to match(/ 2  |   |   |   |/)
    expect(text).to match(/ 3  |   |   |   |/)
    expect(text).to match(/    \+---\+---\+---\+/)
  end

  it 'can display a draw' do
    [[0,0],[0,2],[1,0],[1,2],[2,1]].each do |p|
      @board.set_x(p[0],p[1])
    end
    [[0,1],[1,1],[2,0],[2,2]].each do |p|
      @board.set_o(p[0],p[1])
    end
    text = @display.render_text(@board)
    expect(text).to match(/ 1  | X | O | X |/)
    expect(text).to match(/ 2  | X | O | X |/)
    expect(text).to match(/ 3  | O | X | O |/)
  end

end
