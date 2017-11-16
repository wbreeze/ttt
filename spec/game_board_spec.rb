require 'json'

# rubocop:disable Layout/SpaceAfterComma
# rubocop:disable Layout/SpaceInsideBrackets
# rubocop:disable Style/For
RSpec.describe TttDclovell::GameBoard do
  before :context do
    @range = (0..2)
  end

  before :example do
    @gb = TttDclovell::GameBoard.new
  end

  it 'records x at a row column' do
    for row in @range
      for col in @range
        expect(@gb.get(row, col)).to eq :n
        @gb.set_x(row, col)
        expect(@gb.get(row, col)).to eq :x
      end
    end
  end

  it 'records o at a row column' do
    for row in @range
      for col in @range
        expect(@gb.get(row, col)).to eq :n
        @gb.set_o(row, col)
        expect(@gb.get(row, col)).to eq :o
      end
    end
  end

  it 'enables clear at a row column' do
    for row in @range
      for col in @range
        expect(@gb.get(row, col)).to eq :n
        @gb.set_o(row, col)
        expect(@gb.get(row, col)).to eq :o
        @gb.clear(row, col)
        expect(@gb.get(row, col)).to eq :n
      end
    end
  end

  it 'enables reset' do
    for row in @range
      for col in @range
        expect(@gb.get(row, col)).to eq :n
        @gb.set_x(row, col)
        expect(@gb.get(row, col)).to eq :x
      end
    end
    @gb.reset
    for row in @range
      for col in @range
        expect(@gb.get(row, col)).to eq :n
      end
    end
  end

  it 'allows overwrite' do
    for row in @range
      for col in @range
        expect(@gb.get(row, col)).to eq :n
        @gb.set_x(row, col)
        expect(@gb.get(row, col)).to eq :x
        @gb.set_o(row, col)
        expect(@gb.get(row, col)).to eq :o
        @gb.set_x(row, col)
        expect(@gb.get(row, col)).to eq :x
      end
    end
  end

  it 'recognizes in play' do
    @gb.set_x(0,1)
    @gb.set_o(1,1)
    expect(@gb.state).to eq :incomplete
    expect(@gb.complete?).to be false
  end

  it 'recognizes a draw' do
    [[0,0],[0,2],[1,0],[1,2],[2,1]].each do |p|
      @gb.set_x(p[0],p[1])
    end
    [[0,1],[1,1],[2,0],[2,2]].each do |p|
      @gb.set_o(p[0],p[1])
    end
    expect(@gb.state).to eq :draw
    expect(@gb.complete?).to be true
  end

  it 'recognizes success of x' do
    [[0,0],[0,1],[1,0],[2,0]].each do |p|
      @gb.set_x(p[0],p[1])
    end
    [[0,2],[1,1],[1,2]].each do |p|
      @gb.set_o(p[0],p[1])
    end
    expect(@gb.state).to eq :win_x
    expect(@gb.complete?).to be true
  end

  it 'recognizes success of o' do
    [[0,0],[0,1],[1,1]].each do |p|
      @gb.set_x(p[0],p[1])
    end
    [[0,2],[1,2],[2,2]].each do |p|
      @gb.set_o(p[0],p[1])
    end
    expect(@gb.state).to eq :win_o
    expect(@gb.complete?).to be true
  end

  it 'recognizes column one win' do
    [[0,0],[1,0],[2,0]].each do |p|
      @gb.set_x(p[0],p[1])
    end
    [[0,1],[0,2]].each do |p|
      @gb.set_o(p[0],p[1])
    end
    expect(@gb.state).to eq :win_x
    expect(@gb.complete?).to be true
  end

  it 'recognizes column two win' do
    [[0,1],[1,1],[2,1]].each do |p|
      @gb.set_x(p[0],p[1])
    end
    [[0,0],[0,2]].each do |p|
      @gb.set_o(p[0],p[1])
    end
    expect(@gb.state).to eq :win_x
    expect(@gb.complete?).to be true
  end

  it 'recognizes column three win' do
    [[0,2],[1,2],[2,2]].each do |p|
      @gb.set_x(p[0],p[1])
    end
    [[0,0],[0,1]].each do |p|
      @gb.set_o(p[0],p[1])
    end
    expect(@gb.state).to eq :win_x
    expect(@gb.complete?).to be true
  end

  it 'recognizes row one win' do
    [[0,0],[0,1],[0,2]].each do |p|
      @gb.set_x(p[0],p[1])
    end
    [[1,0],[2,0]].each do |p|
      @gb.set_o(p[0],p[1])
    end
    expect(@gb.state).to eq :win_x
    expect(@gb.complete?).to be true
  end

  it 'recognizes row two win' do
    [[1,0],[1,1],[1,2]].each do |p|
      @gb.set_x(p[0],p[1])
    end
    [[0,0],[2,0]].each do |p|
      @gb.set_o(p[0],p[1])
    end
    expect(@gb.state).to eq :win_x
    expect(@gb.complete?).to be true
  end

  it 'recognizes row three win' do
    [[2,0],[2,1],[2,2]].each do |p|
      @gb.set_x(p[0],p[1])
    end
    [[0,0],[1,0]].each do |p|
      @gb.set_o(p[0],p[1])
    end
    expect(@gb.state).to eq :win_x
    expect(@gb.complete?).to be true
  end

  it 'recognizes backward diagonal win' do
    [[0,0],[1,1],[2,2]].each do |p|
      @gb.set_x(p[0],p[1])
    end
    [[0,1],[1,0]].each do |p|
      @gb.set_o(p[0],p[1])
    end
    expect(@gb.state).to eq :win_x
    expect(@gb.complete?).to be true
  end

  it 'recognizes forward diagonal win' do
    [[0,2],[1,1],[2,0]].each do |p|
      @gb.set_x(p[0],p[1])
    end
    [[0,1],[1,0]].each do |p|
      @gb.set_o(p[0],p[1])
    end
    expect(@gb.state).to eq :win_x
    expect(@gb.complete?).to be true
  end

  it 'provides a compact representation' do
    [[0,2],[1,1],[2,0]].each do |p|
      @gb.set_x(p[0],p[1])
    end
    [[0,1],[1,0]].each do |p|
      @gb.set_o(p[0],p[1])
    end
    jss = @gb.to_json
    expect(jss).to be_a_kind_of(String)
    gbs = JSON.parse(jss)
    expect(gbs).to be_a_kind_of(Hash)
    expect(gbs['game_state']).to be_a_kind_of(Array)
    expect(gbs['game_state']).to match_array(
      [ ' ', 'o', 'x', 'o', 'x', ' ', 'x', ' ', ' ' ]
    )
  end
end
