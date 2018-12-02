class Utils

  def self.read_integers_from_file(file)
    data = File.readlines(file)
    data.map { |line| line.to_i }
  end

  def self.read_words_from_file(file)
    data = File.readlines(file)
    data.map { |line| line.chomp }
  end

end
