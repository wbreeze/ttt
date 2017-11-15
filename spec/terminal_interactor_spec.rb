RSpec.describe TttDclovell::TerminalInteractor do
  class IOEmulator
    attr_accessor :input_list
    attr_reader :output_list
    def initialize
      @output_list = []
    end
    def gets()
      return input_list.shift
    end
    def puts(str)
      @output_list << str
    end
  end

  before :each do
    @ioe = IOEmulator.new
    @ti = TttDclovell::TerminalInteractor.new(@ioe, @ioe)
  end

  it 'captures desire to be X' do
    @ioe.input_list = ['x','q']
    expect(@ti.get_player_role_preference).to eq :first_mover
  end

  it 'captures desire to be O' do
    @ioe.input_list = ['o','q']
    expect(@ti.get_player_role_preference).to eq :second_mover
  end

  it 'captures a move' do
    @ioe.input_list = ['A1','q']
    board = TttDclovell::GameBoard.new
    pos = (@ti.get_player_move(board))
    expect(pos).to be_a_kind_of(Hash)
    expect(pos[:token]).to eq :pos
    expect(pos[:row]).to eq 0
    expect(pos[:col]).to eq 0
  end

  it 'shows help' do
    @ioe.input_list = ['h','A1','q']
    @ti.get_player_move(TttDclovell::GameBoard.new)
    expect(@ioe.output_list[2]).to match(/You can always type 'h' to get this help./)
  end
end
