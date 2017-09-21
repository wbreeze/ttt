RSpec.describe GameState do
  it 'initializes in start by default' do
    gs = GameState.new_game(nil)
    expect(gs.current).to eq :start
  end

  before :each do
    @mc = double('mc')
    allow(@mc).to receive(:check_game_state)
    allow(@mc).to receive(:check_valid_move).and_return true
  end

  context 'callbacks on move' do
    before :each do
      @gs = GameState.new_game(@mc)
    end

    it 'checks for valid move' do
      @gs.x_placed(0, 1)
      expect(@mc).to have_received(:check_valid_move).with(0, 1)
    end

    it 'checks game state after move' do
      @gs.x_placed(0, 0)
      @gs.o_placed(1, 1)
      expect(@mc).to have_received(:check_game_state).twice
    end
  end

  context 'bad transitions' do
    before :each do
      allow(@mc).to receive(:apply_exception)
    end

    it 'does not allow x to move twice' do
      gs = GameState.new_game(@mc, :saw_x)
      gs.x_placed(0,1)
      expect(@mc).to have_received(:check_valid_move)
      expect(@mc).to have_received(:apply_exception)
      expect(@mc).to_not have_received(:check_game_state)
      expect(gs.current).to eq :saw_x
    end

    it 'does not allow o to move twice' do
      gs = GameState.new_game(@mc, :saw_o)
      gs.o_placed(0,1)
      expect(@mc).to have_received(:check_valid_move)
      expect(@mc).to have_received(:apply_exception)
      expect(@mc).to_not have_received(:check_game_state)
      expect(gs.current).to eq :saw_o
    end
  end
end
