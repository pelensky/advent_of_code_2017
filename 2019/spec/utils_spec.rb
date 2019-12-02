# frozen_string_literal: true

require 'utils'

RSpec.describe Utils do
  it 'gets numbers out of a text file' do
    filename = './input/test_integer_data.txt'
    result = [-8, -13, 17, 7, 12]
    expect(Utils.read_integers_from_file(filename)).to eq result
  end

  it 'gets strings from a text file' do
    filename = './input/test_string_data.txt'
    result = %w[Santa can you hear me I have been so good this year]
    expect(Utils.read_words_from_file(filename)).to eq result
  end
end
