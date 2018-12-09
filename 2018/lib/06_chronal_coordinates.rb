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

  def create_grid(coordinates_list)
    highest = find_highest_coordinates(coordinates_list)
    lowest = find_lowest_coordinates(coordinates_list)
    row = Array.new(highest[0] - lowest[0], [])
    columns = Array.new(highest[1] - lowest[1], row)
    {
      x_offset: lowest[0],
      y_offset: lowest[1],
      grid: columns
    }
  end
end
