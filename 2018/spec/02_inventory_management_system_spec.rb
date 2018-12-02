require '02_inventory_management_system'

RSpec.describe InventoryManagement do

  subject(:inventory_management) { described_class.new }

  it 'finds recurring letters' do
    two_a_three_b = 'bababc'
    result = {"a"=>2, "b"=>3}
    expect(inventory_management.find_letters(two_a_three_b)).to eq result
  end

  it 'counts letters with 2, 3, or 2&3 recurring letters' do
    data = ['abcdef', 'bababc', 'abbcde', 'abcccd', 'aabcdd', 'abcdee', 'ababab']
    result = {
      "two" => ['abbcde', 'aabcdd', 'abcdee'],
      "three" => ['abcccd', 'ababab'],
      "both" => ['bababc']
    }

    expect(inventory_management.find_2s_and_3s(data)).to eq result
  end

  it 'gives the number of times a number contains two and a number contains three' do
    data = ['abcdef', 'bababc', 'abbcde', 'abcccd', 'aabcdd', 'abcdee', 'ababab']
    result = {"two" => 4, "three" => 3}
    expect(inventory_management.sums_of_2s_and_3s(data)).to eq result
  end

  it 'multiplies the two by three' do
    data = ['abcdef', 'bababc', 'abbcde', 'abcccd', 'aabcdd', 'abcdee', 'ababab']
    result = 12
    expect(inventory_management.multiply_twos_and_threes(data)).to eq result
  end

  it 'solves the kata' do
    filename = './input/02_inventory_management_system_input.txt'
    expect(inventory_management.check_sum_from_file(filename)).to eq 6200
  end

  it 'finds words that are different by one character' do
    data = ['abcde', 'fghij', 'klmno', 'pqrst', 'fguij', 'axcye', 'wvxyz']
    result = ['fghij', 'fguij']
    expect(inventory_management.find_words_that_differ_by_one_character(data)).to eq result
  end

  it 'finds the position of the different letters' do
    data = ['fghij', 'fguij']
    result = 2
    expect(inventory_management.find_different_letter_position(data)).to eq result
  end

  it 'removes the character from the words' do
    data = ['fghij', 'fguij']
    result = 'fgij'
    expect(inventory_management.delete_wrong_letter(data)).to eq result
  end

  it 'solves q2' do
    filename = './input/02_inventory_management_system_input.txt'
    result = 'xpysnnkqrbuhefmcajodplyzw'
    expect(inventory_management.check_correct_box_id(filename)).to eq result
  end

end
