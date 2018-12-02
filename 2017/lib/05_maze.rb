class Maze
  attr_reader :moves, :maze, :position

  def initialize(input)
    @moves = 0
    @maze = get_maze(input)
    @position = 0
  end

  def exit_maze()
    while @position < @maze.length
      move(@position)
      increase_move_count()
    end
    @moves
  end

  def exit_maze_two()
    while @position < @maze.length
      move_second(@position)
      increase_move_count()
    end
    @moves
  end

  private

  def get_maze(input)
    input.split("\n").map{|move| move.to_i}
  end

  def move(position)
    change_position(position)
    @maze[position] += 1
  end

  def move_second(position)
    change_position(position)
    number_to_move(position) >= 3 ?  @maze[position] -= 1 : @maze[position] += 1
  end

  def increase_move_count()
    @moves += 1
  end

  def number_to_move(position)
    @maze[position]
  end

  def change_position(position)
    @position = (position + number_to_move(position) < 0) ? 0 : position + number_to_move(position)
  end
end
