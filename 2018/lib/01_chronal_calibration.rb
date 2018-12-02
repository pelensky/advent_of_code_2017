require 'utils'

class ChronalCalibration

  def calibrate_frequency(file)
    data = Utils.read_integers_from_file(file)
    find_frequency(data)
  end

  def find_frequency(change)
    change.reduce(0, :+)
  end

  def find_first_frequency_reached_twice(change)
    frequencies = list_frequencies_until_one_reached_twice(change)
    first_duplicate(frequencies)
  end

  def list_frequencies_until_one_reached_twice(change)
    all_frequencies = []
    starting_index = 0
    until !duplicate?(all_frequencies)
      list_frequencies(change, all_frequencies, starting_index)
      starting_index += change.length
    end
    all_frequencies
  end

  def list_frequencies(change, frequencies = [], starting_index = 0)
    change.each_with_index do |number, index|
      frequency_index = starting_index + index - 1
      starting = frequencies[frequency_index] || 0
      ending_frequency = starting + number
      frequencies << ending_frequency
      break if !duplicate?(frequencies)
    end
    frequencies
  end

  def duplicate?(frequency)
    frequency.length == frequency.uniq.length
  end

  def first_duplicate(list)
    list.group_by{|e| e}.keep_if{|_, e| e.length > 1}.keys[0]
  end

  def first_duplicate_from_file(filename)
    list = Utils.read_integers_from_file(filename)
    find_first_frequency_reached_twice(list)
  end

end
