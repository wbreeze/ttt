RSpec.describe TttDclovell::TicTacToe do
  it 'loads up' do
    expect(defined? TttDclovell::TicTacToe).to_not be_nil
    expect(defined? TttDclovell::CommandParser).to_not be_nil
  end
end
