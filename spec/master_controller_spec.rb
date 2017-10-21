RSpec.describe MasterController do
  before :each do
    @interact = instance_double('TerminalInteractor')
  end

  # mock setup can't be done in before blocks
  def setup_interact
    allow(@interact).to receive('get_player_move').and_return({
      :token => :bye
    })
    allow(@interact).to receive('thank_partner')
    allow(@interact).to receive('goodbye')
  end

  it 'Quits if quit given at first prompt' do
    setup_interact
    expect(@interact).to receive('get_player_role_preference').and_return(:bye)
    mc = MasterController.new(@interact)
    mc.play
    expect(@interact).to have_received('goodbye')
  end

  it 'Accepts user as X' do
    setup_interact
    expect(@interact).to receive('get_player_role_preference').and_return(:first_mover)
    mc = MasterController.new(@interact)
    mc.play
    expect(@interact).to have_received('goodbye')
  end

  it 'Accepts user as O' do
    setup_interact
    expect(@interact).to receive('get_player_role_preference').and_return(:second_mover)
    mc = MasterController.new(@interact)
    mc.play
    expect(@interact).to have_received('goodbye')
  end

  it 'Accepts a move' do
    setup_interact
    allow(@interact).to receive('get_player_role_preference').and_return(:first_mover)
    expect(@interact).to receive('get_player_move').and_return({
      :token => :pos,
      row: 0,
      col: 0
    })
    mc = MasterController.new(@interact)
    mc.play
    expect(@interact).to have_received('goodbye')
  end
end
