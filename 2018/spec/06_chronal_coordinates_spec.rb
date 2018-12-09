require '06_chronal_coordinates'

RSpec.describe ChronalCoordinates do
  subject(:chronal_coordinates) { described_class.new }
  coordinates = [
    [1, 1],
    [1, 6],
    [8, 3],
    [3, 4],
    [5, 5],
    [8, 9]
  ]

  it 'gets the highest and y coordinates' do
    result = [8, 9]
    expect(chronal_coordinates.find_highest_coordinates(coordinates)).to eq result
  end

  it 'gets the lowest x and y coordinates' do
    result = [1, 1]
    expect(chronal_coordinates.find_lowest_coordinates(coordinates)).to eq result
  end

  it 'creates a grid with offsets' do
    number_of_columns = 9 - 1
    number_of_rows = 8 - 1
    expect(chronal_coordinates.create_grid(coordinates)[:x_offset]).to eq 1
    expect(chronal_coordinates.create_grid(coordinates)[:y_offset]).to eq 1
    expect(chronal_coordinates.create_grid(coordinates)[:grid].length).to eq number_of_columns
    expect(chronal_coordinates.create_grid(coordinates)[:grid][0].length).to eq number_of_rows
  end
end
