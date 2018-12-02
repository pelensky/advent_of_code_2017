require '01_chronal_calibration'

RSpec.describe ChronalCalibration do
  subject :chronal_calibration { described_class.new }

  it 'handles a frequency change' do
    change = [+1]
    expect(chronal_calibration.find_frequency(change)).to eq 1
  end

  it 'handles two changes' do
    change = [+1, -2]
    expect(chronal_calibration.find_frequency(change)).to eq -1
  end

  it 'handles a number of changes' do
    change = [+1, -2, +3, +1]
    expect(chronal_calibration.find_frequency(change)).to eq 3
  end

  it 'handlels the test data' do
    change = [-8, -13, 17, 7, 12]
    expect(chronal_calibration.find_frequency(change)).to eq 15
  end

  it 'sums the numbers from a text file' do
    filename = './input/test_integer_data.txt'
    expect(chronal_calibration.calibrate_frequency(filename)).to eq 15
  end

  it 'solves step one of the kata' do
    filename = './input/01_chronal_calibration_input.txt'
    expect(chronal_calibration.calibrate_frequency(filename)).to eq 490
  end

  it 'finds the first duplicated element in an array' do
    list = [0, -5, 2, -5, 7, 7]
    expect(chronal_calibration.first_duplicate(list)).to eq -5
  end

  it 'finds the first frequency reached twice' do
    change = [+1, -2, +3, +1]
    expect(chronal_calibration.find_first_frequency_reached_twice(change)).to eq 2
  end

  it 'outputs a list of frequencies that it reaches' do
    change = [+1, -2, +3, +1]
    result = [1, -1, 2, 3]
    expect(chronal_calibration.list_frequencies(change)).to eq result
  end

  it 'continues outputting a list of frequencies until one is found twice' do
    change = [+1, -2, +3, +1]
    result = [1, -1, 2, 3, 4, 2]
    expect(chronal_calibration.list_frequencies_until_one_reached_twice(change)).to eq result
  end

  it 'finds first dupliclate' do
    change = [+1, -2, +3, +1]
    expect(chronal_calibration.find_first_frequency_reached_twice(change)).to eq 2
  end

  it 'finds first duplicate ex 2' do
    change = [+3, +3, +4, -2, -4]
    expect(chronal_calibration.find_first_frequency_reached_twice(change)).to eq 10
  end


  it 'finds first duplicate ex 3' do
    change = [+7, +7, -2, -7, -4]
    expect(chronal_calibration.find_first_frequency_reached_twice(change)).to eq 14
  end

  # it 'finds the first duplicated element in an array from a file' do
  #   filename = './input/01_chronal_calibration_input.txt'
  #   expect(chronal_calibration.first_duplicate_from_file(filename)).to eq 70357
  # end

end
