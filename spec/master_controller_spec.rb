RSpec.describe TttDclovell::MasterController do
  before :example do
    @interact = instance_double('TerminalInteractor')
  end

  # mock setup can't be done in before blocks
  def setup_interact
    allow(@interact).to receive('get_player_move').and_return(
      :token => :bye
    )
    allow(@interact).to receive('thank_partner')
    allow(@interact).to receive('goodbye')
  end

  it 'Quits if quit given at first prompt' do
    setup_interact
    expect(@interact).to receive('get_player_role_preference').and_return(:bye)
    mc = TttDclovell::MasterController.new(@interact)
    mc.play
    expect(@interact).to have_received('goodbye')
  end

  it 'Accepts user as X' do
    setup_interact
    expect(@interact).to receive(
      'get_player_role_preference').and_return(:first_mover)
    mc = TttDclovell::MasterController.new(@interact)
    mc.play
    expect(@interact).to have_received('goodbye')
  end

  it 'Accepts user as O' do
    setup_interact
    expect(@interact).to receive(
      'get_player_role_preference').and_return(:second_mover)
    mc = TttDclovell::MasterController.new(@interact)
    mc.play
    expect(@interact).to have_received('goodbye')
  end

  it 'Accepts a move' do
    setup_interact
    allow(@interact).to receive(
      'get_player_role_preference').and_return(:first_mover)
    expect(@interact).to receive('get_player_move').and_return(
      :token => :pos,
      row: 0,
      col: 0
    )
    mc = TttDclovell::MasterController.new(@interact)
    mc.play
    expect(@interact).to have_received('goodbye')
  end
end
