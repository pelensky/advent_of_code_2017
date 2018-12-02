class CorruptionChecksum

  def compute_sum(input)
    sum(get_difference(get_sorted_lines(input)))
  end

  def compute_division(input)
    sum(get_divisible_numbers_by_line(get_sorted_lines(input)))
  end

  private

  def get_divisible_numbers(line)
    divisible_numbers = []
    line.each do |divisor|
      line.select do |quotient|
        divisible_numbers = put_divisible_numbers_in_array(quotient, divisor, divisible_numbers)
      end
    end
    divisible_numbers.last / divisible_numbers.first
  end

  def get_divisible_numbers_by_line(lines)
    lines.map {|line| get_divisible_numbers(line)}
  end


  def put_divisible_numbers_in_array(quotient, divisor, divisible_numbers)
    if quotient % divisor == 0 && quotient != divisor
      divisible_numbers.push(divisor)
      divisible_numbers.push(quotient)
    end
    divisible_numbers
  end

  def get_difference(lines)
    lines.map {|line| line.last - line.first}
  end

  def get_sorted_lines(input)
    input.split("\n").map do |line|
      get_numbers(line.strip)
    end
  end

  def get_numbers(line)
    line.split(" ").map {|number| number.to_i}.sort!
  end

  def sum(values)
    values.inject(0, :+)
  end

end
