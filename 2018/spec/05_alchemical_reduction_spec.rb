require '05_alchemical_reduction'

RSpec.describe AlchemicalReduction do
  subject(:alchemical_reduction) { described_class.new }

  it 'destroys opposite polarity molecules' do
    polymers = %w(
    aA bB cC dD eE fF gG hH iI jJ kK lL mM
    nN oO pP qQ rR sS tT uU vV wW xX yY zZ
    Aa Bb Cc Dd Ee Ff Gg Hh Ii Jj Kk Ll Mm
    Nn Oo Pp Qq Rr Ss Tt Uu Vv Ww Xx Yy Zz
    )
    polymers.each do |polymer|
      expect(alchemical_reduction.destroy_polar_opposites(polymer)).to eq ''
    end
  end

  it 'moves on to the next' do
    expect(alchemical_reduction.destroy_polar_opposites('abBA')).to eq ''
  end

  it 'leaves the remaining molecules' do
    expect(alchemical_reduction.destroy_polar_opposites('abAB')).to eq 'abAB'
    expect(alchemical_reduction.destroy_polar_opposites('aabAAB')).to eq 'aabAAB'
    expect(alchemical_reduction.destroy_polar_opposites('dabAcCaCBAcCcaDA')).to eq 'dabCBAcaDA'
  end

  # it 'solves q1' do
  #   filename = './input/05_alchemical_reduction_input.txt'
  #   expect(alchemical_reduction.find_resulting_polymer_length(filename)).to eq 9822
  # end

  it 'removes offending letters and tracks the resulting length' do
    input = 'dabAcCaCBAcCcaDA'
    length = 4
    expect(alchemical_reduction.find_shortest_polymer_without_a_letter(input)).to eq length
  end

  # it 'solves q2' do
  #   filename = './input/05_alchemical_reduction_input.txt'
  #   expect(alchemical_reduction.find_shortest_from_file(filename)).to eq 5726
  # end
end
