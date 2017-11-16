RSpec.describe TttDclovell::GameState do
  it 'initializes in limbo by default' do
    gs = TttDclovell::GameState.new_game(nil)
    expect(gs.current).to eq :limbo
  end

  before :each do
    @mc = double('MasterController')
    allow(@mc).to receive(:get_moving)
    allow(@mc).to receive(:check_game_state)
    allow(@mc).to receive(:check_and_play).and_return true
  end

  context 'calls get_moving on select player' do
    it 'gets moving with first mover select' do
      @gs = TttDclovell::GameState.new_game(@mc)
      @gs.role_selected(:first_mover)
      expect(@mc).to have_received(:get_moving)
    end
    it 'gets moving with second mover select' do
      @gs = TttDclovell::GameState.new_game(@mc)
      @gs.role_selected(:second_mover)
      expect(@mc).to have_received(:get_moving)
    end
  end

  context 'callbacks on move' do
    before :each do
      @gs = TttDclovell::GameState.new_game(@mc)
      @gs.role_selected(:first_mover)
    end

    it 'checks for valid move' do
      @gs.x_placed(0, 1)
      expect(@mc).to have_received(:check_and_play).with(:x, 0, 1)
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
      gs = TttDclovell::GameState.new_game(@mc, :saw_x)
      gs.x_placed(0, 1)
      expect(@mc).not_to have_received(:check_and_play)
      expect(@mc).to have_received(:apply_exception)
      expect(@mc).not_to have_received(:check_game_state)
      expect(gs.current).to eq :saw_x
    end

    it 'does not allow o to move twice' do
      gs = TttDclovell::GameState.new_game(@mc, :saw_o)
      gs.o_placed(0, 1)
      expect(@mc).not_to have_received(:check_and_play)
      expect(@mc).to have_received(:apply_exception)
      expect(@mc).not_to have_received(:check_game_state)
      expect(gs.current).to eq :saw_o
    end
  end
end
