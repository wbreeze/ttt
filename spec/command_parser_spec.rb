RSpec.describe 'CammandParser' do
  before :all do
    @cp = CommandParser.new
  end

  it 'recognizes help' do
    expect(@cp.parse("h")).to eq :help
    expect(@cp.parse(" h ")).to eq :help
    expect(@cp.parse(" h \n")).to eq :help
    expect(@cp.parse("H")).to eq :help
    expect(@cp.parse("help")).to eq :help
    expect(@cp.parse("Help")).to eq :help
    expect(@cp.parse("HELP")).to eq :help
  end

  it 'does not recognize malformed help' do
    expect(@cp.parse("hel")).to eq :unrecognized
    expect(@cp.parse("h el")).to eq :unrecognized
    expect(@cp.parse("he")).to eq :unrecognized
    expect(@cp.parse("elp")).to eq :unrecognized
  end

  it 'recognizes X' do
    expect(@cp.parse("x")).to eq :be_x
    expect(@cp.parse("X")).to eq :be_x
    expect(@cp.parse("x\n")).to eq :be_x
  end

  it 'recognizes Y' do
    expect(@cp.parse("y")).to eq :be_y
    expect(@cp.parse("Y")).to eq :be_y
  end

  it 'recognizes yes' do
    expect(@cp.parse("yes")).to eq :yes
    expect(@cp.parse("Yes")).to eq :yes
    expect(@cp.parse("YES")).to eq :yes
  end

  it 'recognizes no' do
    expect(@cp.parse("n")).to eq :no
    expect(@cp.parse("no")).to eq :no
    expect(@cp.parse("No")).to eq :no
    expect(@cp.parse("NO")).to eq :no
  end

  it 'recognizes bye' do
    expect(@cp.parse("bye")).to eq :bye
    expect(@cp.parse("Bye")).to eq :bye
    expect(@cp.parse("BYE")).to eq :bye
    expect(@cp.parse("exit")).to eq :bye
    expect(@cp.parse("quit")).to eq :bye
    expect(@cp.parse("q")).to eq :bye
    expect(@cp.parse("Q")).to eq :bye
    expect(@cp.parse("done")).to eq :bye
    expect(@cp.parse("uncle")).to eq :bye
    expect(@cp.parse("ciao")).to eq :bye
    expect(@cp.parse("chau")).to eq :bye
    expect(@cp.parse("chao")).to eq :bye
  end

  it 'recognizes position' do
    expect(@cp.parse(" A 1 ")).to eq :pos
    expect(@cp.parse("a1")).to eq :pos
    expect(@cp.parse("A1")).to eq :pos
    expect(@cp.row).to eq 0
    expect(@cp.col).to eq 0
    expect(@cp.parse("B1")).to eq :pos
    expect(@cp.row).to eq 0
    expect(@cp.col).to eq 1
    expect(@cp.parse("C1")).to eq :pos
    expect(@cp.row).to eq 0
    expect(@cp.col).to eq 2
    expect(@cp.parse("A2")).to eq :pos
    expect(@cp.row).to eq 1
    expect(@cp.col).to eq 0
    expect(@cp.parse("B2")).to eq :pos
    expect(@cp.row).to eq 1
    expect(@cp.col).to eq 1
    expect(@cp.parse("C2")).to eq :pos
    expect(@cp.row).to eq 1
    expect(@cp.col).to eq 2
    expect(@cp.parse("A3")).to eq :pos
    expect(@cp.row).to eq 2
    expect(@cp.col).to eq 0
    expect(@cp.parse("B3")).to eq :pos
    expect(@cp.row).to eq 2
    expect(@cp.col).to eq 1
    expect(@cp.parse("C3")).to eq :pos
    expect(@cp.row).to eq 2
    expect(@cp.col).to eq 2
  end

  it 'recognizes invalid col' do
    expect(@cp.parse("D1")).to eq :unrecognized
    expect(@cp.col).to eq CommandParser::INVALID_POSITION
    expect(@cp.parse("X1")).to eq :unrecognized
    expect(@cp.col).to eq CommandParser::INVALID_POSITION
  end

  it 'recognizes invalid row' do
    expect(@cp.parse("A4")).to eq :unrecognized
    expect(@cp.row).to eq CommandParser::INVALID_POSITION
    expect(@cp.parse("A10")).to eq :unrecognized
    expect(@cp.row).to eq CommandParser::INVALID_POSITION
  end

  it 'rejects bad position' do
    expect(@cp.parse("A4")).to eq :unrecognized
    expect(@cp.parse("D1")).to eq :unrecognized
  end

  it 'resets pos on parse' do
    expect(@cp.parse("A1")).to eq :pos
    expect(@cp.row).to eq 0
    expect(@cp.col).to eq 0
    expect(@cp.parse("n")).to eq :no
    expect(@cp.row).to eq CommandParser::INVALID_POSITION
    expect(@cp.col).to eq CommandParser::INVALID_POSITION
  end

  it 'sets pos on initialization' do
    ncp = CommandParser.new
    expect(ncp.row).to eq CommandParser::INVALID_POSITION
    expect(ncp.col).to eq CommandParser::INVALID_POSITION
  end
end
