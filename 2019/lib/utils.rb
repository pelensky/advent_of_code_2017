# frozen_string_literal: true

class Utils
  def self.read_integers_from_file(file)
    data = File.readlines(file)
    data.map(&:to_i)
  end

  def self.read_words_from_file(file)
    data = File.readlines(file)
    data.map(&:chomp)
  end
end
