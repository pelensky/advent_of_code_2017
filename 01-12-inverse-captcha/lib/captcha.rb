class Captcha

  def sum(number)
    find_matching_numbers(number).inject(0, :+)
  end

  def find_matching_numbers(number)
    split_numbers = number.to_s.chars.map(&:to_i)
    numbers_that_match = number_matches_next(split_numbers)
    first_and_last_numbers_match(split_numbers, numbers_that_match)
    numbers_that_match
  end

  private

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

end
