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
    number_of_columns = 9
    number_of_rows = 8
    expect(chronal_coordinates.create_grid_with_offsets(coordinates)[:x_offset]).to eq 1
    expect(chronal_coordinates.create_grid_with_offsets(coordinates)[:y_offset]).to eq 1
    expect(chronal_coordinates.create_grid_with_offsets(coordinates)[:grid].length).to eq number_of_columns
    expect(chronal_coordinates.create_grid_with_offsets(coordinates)[:grid][0].length).to eq number_of_rows
  end

  it 'plots the coordinates' do
    result = [
      ['COORDINATE 0', [], [], [], [], [], [], []],
      [[], [], [], [], [], [], [], []],
      [[], [], [], [], [], [], [], 'COORDINATE 2'],
      [[], [], 'COORDINATE 3', [], [], [], [], []],
      [[], [], [], [], 'COORDINATE 4', [], [], []],
      ['COORDINATE 1', [], [], [], [], [], [], []],
      [[], [], [], [], [], [], [], []],
      [[], [], [], [], [], [], [], []],
      [[], [], [], [], [], [], [], 'COORDINATE 5']
    ]
    expect(chronal_coordinates.plot(coordinates)[:grid]).to eq result
  end
end
