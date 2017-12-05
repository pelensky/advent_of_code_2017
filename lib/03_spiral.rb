class Spiral
  attr_reader :grid
  def initialize()
    @grid = [[0, 0]]
  end

  def build_grid(number)
    num = 1
    turns = 1
    most_recent_coordinate = @grid.last
    most_recent_x = most_recent_coordinate[0]
    most_recent_y = most_recent_coordinate[1]
    while num < number
      if num == 1
        @grid.push(right(most_recent_coordinate))
      end
      num += 1
    end
    @grid
  end

  private

  def right(coordinate)
    x = coordinate[0] + 1
    y = coordinate[1]
    [x, y]
  end

  def up(coordinate)
    x = coordinate[0]
    y = coordinate[1] + 1
    [x, y]
  end

  def left(coordinate)
    x = coordinate[0] - 1
    y = coordinate[1]
    [x, y]
  end

  def down(coordinate)
    x = coordinate[0]
    y = coordinate[1] - 1
    [x, y]
  end
end
