class Captcha

  def get_sum_of_matching_numbers_next_to_each_other(number)
    sum(find_matching_numbers(number))
  end

  def get_sum_of_far_numbers(number)
    sum(find_far_numbers(number))
  end

  def find_matching_numbers(number)
    split_numbers = split_numbers(number)
    numbers_that_match = number_matches_next(split_numbers)
    first_and_last_numbers_match(split_numbers, numbers_that_match)
    numbers_that_match
  end

  def find_far_numbers(number)
    split_numbers = split_numbers(number)
    numbers_that_match = number_matches_half_way(split_numbers)
  end

  private

  def sum(numbers)
    numbers.inject(0, :+)
  end

  def split_numbers(number)
    number.to_s.chars.map(&:to_i)
  end

  def number_matches_next(split_numbers)
    split_numbers.select.each_with_index do |current_number, index|
      current_number == split_numbers[index + 1]
    end
  end

  def first_and_last_numbers_match(all_numbers, numbers_that_match)
    if all_numbers.first == all_numbers.last
      numbers_that_match.push(all_numbers.first)
    end
  end

  def number_matches_half_way(split_number)
    index_to_compare = split_number.length/2
    split_number.select.each_with_index do |current_number, index|
      index_to_check = index + index_to_compare
      number_to_check = (index_to_check >= index) ? index - index_to_compare : index_to_check
      current_number == split_number[number_to_check]
    end
  end

end
