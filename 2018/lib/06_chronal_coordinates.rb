require 'utils'

class ChronalCoordinates
  def find_highest_coordinates(coordinates_list)
    highest_x = coordinates_list.max_by { |c| c[0] }
    highest_y = coordinates_list.max_by { |c| c[1] }
    [highest_x[0], highest_y[1]]
  end

  def find_lowest_coordinates(coordinates_list)
    lowest_x = coordinates_list.min_by { |c| c[0] }
    lowest_y = coordinates_list.min_by { |c| c[1] }
    [lowest_x[0], lowest_y[1]]
  end

  def create_grid_with_offsets(coordinates_list)
    highest = find_highest_coordinates(coordinates_list)
    lowest = find_lowest_coordinates(coordinates_list)
    grid = Array.new(highest[1] - lowest[1] + 1) {
      Array.new(highest[0] - lowest[0] + 1) {[]}
    }
    {
      x_offset: lowest[0],
      y_offset: lowest[1],
      grid: grid
    }
  end

  def plot(coordinates_list)
    grid_with_offsets = create_grid_with_offsets(coordinates_list)
    coordinates_list.each_with_index do |coordinate, index|
      x = coordinate[0] - grid_with_offsets[:x_offset]
      y = coordinate[1] - grid_with_offsets[:y_offset]
      grid_with_offsets[:grid][y][x] = "COORDINATE #{index}"
    end
    grid_with_offsets
  end
end
