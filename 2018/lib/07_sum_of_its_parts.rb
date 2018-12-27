class SumOfItsParts

  def transform(parts)
    transformed = {}

    parts.each do |part|
      instructions = get_letters(part)
      (transformed[instructions[0]] ||= []) << instructions[1]
      transformed[instructions[0]].sort!
    end
    transformed

  end

  private

  def get_letters(part)
    [
      part[5],
      part[-12]
    ]
  end
end
