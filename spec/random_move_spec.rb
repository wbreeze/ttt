RSpec.describe TttDclovell::RandomMoveStrategy do
  before :example do
    @strat = TttDclovell::RandomMoveStrategy.new
    @gb = TttDclovell::GameBoard.new
    [[0,0],[0,2],[1,0],[1,2],[2,1]].each do |p|
      @gb.set_x(p[0],p[1])
    end
    [[0,1],[1,1],[2,0],[2,2]].each do |p|
      @gb.set_o(p[0],p[1])
    end
  end

  it 'finds the one open move' do
    @gb.clear(1,2)
    move = @strat.generate_move(@gb)
    expect(move[:row]).to eq 1
    expect(move[:col]).to eq 2
  end

  it 'returns if the board is full' do
    move = @strat.generate_move(@gb)
    expect(move[:token]).to eq :pos
  end
end
