require '03_spiral'

RSpec.describe Spiral do
  subject(:spiral) { described_class.new }

  context "building the grid" do
    it "initializes with an empty grid" do
      expect(spiral.grid).to eq [[0,0]]
    end

    it "2" do
      expect(spiral.build_grid(2)).to eq [[0, 0], [1, 0]]
    end

    it "3" do
      expect(spiral.build_grid(3)).to eq [[0, 0], [1, 0], [1, 1]]
    end
  end

end
