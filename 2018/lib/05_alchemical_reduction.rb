require 'utils'

class AlchemicalReduction
  PAIRS = [
    %w(aA Aa), %w(bB Bb), %w(cC Cc), %w(dD Dd), %w(eE Ee),
    %w(fF Ff), %w(gG Gg), %w(hH Hh), %w(iI Ii), %w(jJ Jj),
    %w(kK Kk), %w(lL Ll), %w(mM Mm), %w(nN Nn), %w(oO Oo),
    %w(pP Pp), %w(qQ Qq), %w(rR Rr), %w(sS Ss), %w(tT Tt),
    %w(uU Uu), %w(vV Vv), %w(wW Ww), %w(xX Xx), %w(yY Yy),
    %w(zZ Zz)
  ]
  POLAR_OPPOSITES = PAIRS.flatten

  def destroy_polar_opposites(polymer)
    POLAR_OPPOSITES.each do |polar_opposite|
      polymer.gsub!(polar_opposite, '')
    end
    destroy_polar_opposites(polymer) if contains_polar_opposites?(polymer)
    polymer
  end

  def find_resulting_polymer_length(filename)
    find_resulting_polymer(filename).length
  end

  def find_shortest_polymer_without_a_letter(polymer)
    results = {}
    ('a'..'z').each do |letter|
      cloned = polymer.dup
      cloned.gsub!(letter, '')
      cloned.gsub!(letter.upcase, '')
      results[letter] = destroy_polar_opposites(cloned).length
    end
    results.min_by { |_k, v| v }[1]
  end

  def find_shortest_from_file(filename)
    polymer = Utils.read_words_from_file(filename)[0]
    find_shortest_polymer_without_a_letter(polymer)
  end

  private

  def contains_polar_opposites?(polymer)
    POLAR_OPPOSITES.any? do |polar_opposite|
      polymer.include?(polar_opposite)
    end
  end

  def find_resulting_polymer(filename)
    polymer = Utils.read_words_from_file(filename)[0]
    destroy_polar_opposites(polymer)
  end
end
