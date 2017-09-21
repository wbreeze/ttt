RSpec.describe TerminalInteractor do
  class IOEmulator
    attr_accessor :next_input
    def gets()
      return next_input.shift
    end
    def puts(str)
    end
  end

  before :all do
    @ioe = IOEmulator.new
  end

  it 'captures desire to be X' do
    ti = TerminalInteractor.new(@ioe, @ioe)
    @ioe.next_input = ['x','q']
    expect(ti.get_player_role_preference).to eq :first_mover
  end

  it 'captures desire to be O' do
    ti = TerminalInteractor.new(@ioe, @ioe)
    @ioe.next_input = ['o','q']
    expect(ti.get_player_role_preference).to eq :second_mover
  end
end
