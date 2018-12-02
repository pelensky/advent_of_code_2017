require '05_maze'

RSpec.describe Maze do

  initial_input = "0\n3\n0\n1\n-3"
  initial_moves = [0, 3, 0, 1, -3]
  final_maze = [2,  5,  0,  1,  -2]
  input = File.read(File.join(File.dirname(__FILE__), '../input/05.txt'))

  subject(:maze) { described_class.new(initial_input)}
  subject(:file) { described_class.new(input)}

  it "start with zero moves" do
    expect(maze.moves).to eq 0
  end

  it "converts the input into a list of moves" do
    expect(maze.maze).to eq initial_moves
  end

  it "starts in position zero" do
    expect(maze.position).to eq 0
  end

  it "counts the moves" do
    expect(maze.exit_maze()).to eq 5
  end

  it "reveals the state of the maze" do
    maze.exit_maze()
    expect(maze.maze).to eq final_maze
  end

  it "counts the moves for a file" do
    expect(file.exit_maze()).to eq 351282
  end

  it "counts the moves in the second maze" do
    expect(file.exit_maze_two()).to eq 24568703
  end


end
