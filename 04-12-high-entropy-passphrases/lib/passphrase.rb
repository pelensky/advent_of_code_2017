class Passphrase

  def count_valid_passphrases(input)
    select_valid_passphrases(split_passphrases(input)).count
  end

  def count_valid_passphrases_without_anagrams(input)
    select_valid_passphrases_without_anagrams(split_passphrases(input)).count
  end

  def split_passphrases(passphrases)
    passphrases.split("\n").map {|passphrase| passphrase.strip}
  end

  def select_valid_passphrases(list_of_passphrases)
    list_of_passphrases.select do |passphrase|
     no_duplicate_words?(passphrase)
    end
  end

  def select_valid_passphrases_without_anagrams(list_of_passphrases)
    list_of_passphrases.select {|passphrase| no_anagrams?(passphrase)}
  end

  private

  def no_duplicate_words?(passphrase)
    words = passphrase.split(" ")
    unique_words = words.uniq
    unique_words.length == words.length
  end

  def no_anagrams?(passphrase)
    words = passphrase.split(" ")
    sorted_words = words.map{|word| word.chars.sort.join}
    sorted_words.uniq.length == words.length
  end
end
