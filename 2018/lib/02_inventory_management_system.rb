require 'utils'

class InventoryManagement

  def find_letters(word)
    split_word = word.split('')
    letters = split_word.group_by{|e| e}.keep_if{|_, e| e.length > 1}
    letters.each { |k, v| letters[k] = v.length }
  end

  def find_2s_and_3s(words)
    dictionary = {
      'both' => [],
      'three' => [],
      'two' => []
    }
    words.each do |word|
      counts = find_letters(word)
      if counts.has_value?(2) && counts.has_value?(3)
        dictionary['both'] << word
      elsif counts.has_value?(3)
        dictionary['three'] << word
      elsif counts.has_value?(2)
        dictionary['two'] << word
      end
    end
    dictionary
  end

  def sums_of_2s_and_3s(data)
    twos_and_threes = find_2s_and_3s(data)
    twos_and_threes.each { |k, v| twos_and_threes[k] = v.length }
    twos_and_threes['three'] += twos_and_threes['both']
    twos_and_threes['two'] += twos_and_threes['both']
    twos_and_threes.delete('both')
    twos_and_threes
  end

  def multiply_twos_and_threes(data)
    twos_and_threes = sums_of_2s_and_3s(data)
    twos_and_threes['two'] * twos_and_threes['three']
  end

  def check_sum_from_file(filename)
    words = Utils.read_words_from_file(filename)
    multiply_twos_and_threes(words)
  end
end
