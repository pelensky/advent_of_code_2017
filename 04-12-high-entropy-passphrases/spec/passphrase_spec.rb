require 'passphrase'

RSpec.describe Passphrase do

  subject(:passphrase) { described_class.new }

  passphrases = "vxjtwn vjnxtw sxibvv mmws wjvtxn icawnd rprh
    fhaa qwy vqbq gsswej lxr yzl wakcige mwjrl
    bhnlow huqa gtbjc gvj wrkyr jgvmhj bgs umo ikbpdto"

  individual_passphrases = ["vxjtwn vjnxtw sxibvv mmws wjvtxn icawnd rprh",
                            "fhaa qwy vqbq gsswej lxr yzl wakcige mwjrl",
                            "bhnlow huqa gtbjc gvj wrkyr jgvmhj bgs umo ikbpdto"]

  input = File.read(File.join(File.dirname(__FILE__), '../lib/input.txt'))

  it "breaks passwords apart" do
    expect(passphrase.split_passphrases(passphrases)).to eq individual_passphrases
  end

  it "selects valid passwords" do
    expect(passphrase.select_valid_passphrases(individual_passphrases)).to eq individual_passphrases
  end

  it "counts the number for the file" do
    expect(passphrase.count_valid_passphrases(input)).to eq 451
  end

  it "selects valid passwords without anagrams" do
    expect(passphrase.select_valid_passphrases_without_anagrams(["dan"])).to eq ["dan"]
  end

  it "counts valid passphrases without anagrams" do
    expect(passphrase.count_valid_passphrases_without_anagrams(input)).to eq 223
  end

end
