require '03_no_matter_how_you_slice_it'

RSpec.describe Claim do

  subject(:claim) { described_class.new }

  it 'transforms the data' do
    data = '#123 @ 3,2: 5x4'
    result = {
      'id': 123,
      'left': 3,
      'top': 2,
      'width': 5,
      'height': 4
    }

    expect(claim.transform(data)).to eq result
  end

  it 'finds coordinates covered' do
    data = {
      'id': 123,
      'left': 3,
      'top': 2,
      'width': 5,
      'height': 4
    }
    coordinates = [
      [2, 3], [2, 4], [2, 5], [2, 6], [2,7],
      [3, 3], [3, 4], [3, 5], [3, 6], [3, 7],
      [4, 3], [4, 4], [4, 5], [4, 6], [4, 7],
      [5, 3], [5, 4], [5, 5], [5, 6], [5, 7]
    ]
    get_coordinates_from_result = claim.add_coordinates(data).map {|claim| claim[:coordinates] }

    expect(get_coordinates_from_result).to eq coordinates
  end

   it 'finds the number of coordinates covered by 2 or more claims' do
     data = ['#1 @ 1,3: 4x4', '#2 @ 3,1: 4x4', '#3 @ 5,5: 2x2']
     result = [[3, 3], [3, 4], [4, 3], [4, 4]]

    expect(claim.see_overlap(data)).to eq result
  end

  it 'counts the number of coordinates covered by 2 or more claims' do
    data = ['#1 @ 1,3: 4x4', '#2 @ 3,1: 4x4', '#3 @ 5,5: 2x2']

    expect(claim.count_overlap(data)).to eq 4
  end

  # it 'solves q1' do
  #   filename = './input/03_no_matter_how_you_slice_it_input.txt'
  #   expect(claim.see_how_much_fabric_overlaps(filename)).to eq 120419
  # end
  #
  # it 'finds the claim that does not overlap' do
  #   data = ['#1 @ 1,3: 4x4', '#2 @ 3,1: 4x4', '#3 @ 5,5: 2x2']
  #  result = 3
  #
  #   expect(claim.see_where_no_overlap(data)).to eq result
  # end

end
