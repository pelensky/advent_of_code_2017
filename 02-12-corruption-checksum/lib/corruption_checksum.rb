class CorruptionChecksum

  def compute_sum(input)
    sum(get_difference(get_values(input)))
  end

  def get_values(input)
    lines = get_lines(input)
  end

  def get_difference(lines)
    lines.map {|line| line.last - line.first}
  end

  def sum(values)
    values.inject(0, :+)
  end

  private

  def get_lines(input)
    input.split("\n").map do |line|
      get_numbers(line.strip)
    end
  end

  def get_numbers(line)
    line.split(" ").map {|number| number.to_i}.sort!
  end

end
