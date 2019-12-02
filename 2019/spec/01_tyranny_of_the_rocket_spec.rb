# frozen_string_literal: true

require '01_tyranny_of_the_rocket'

RSpec.describe TyrannyOfTheRocket do
  subject(:rocket) { described_class.new }

  it 'finds fuel required for a module' do
    expect(rocket.find_fuel_required(12)).to eq 2
    expect(rocket.find_fuel_required(14)).to eq 2
    expect(rocket.find_fuel_required(1969)).to eq 654
    expect(rocket.find_fuel_required(100_756)).to eq 33_583
  end

  it 'finds the total fuel required excluding fuel' do
    expect(rocket.find_total_fuel_required).to eq 3_352_674
  end

  it 'calcultes fuel required for a module, including fuel' do
    expect(rocket.find_fuel_required_including_fuel_for_fuel(12)).to eq 2
    expect(rocket.find_fuel_required_including_fuel_for_fuel(1969)).to eq 966
    expect(rocket.find_fuel_required_including_fuel_for_fuel(100_756)).to eq 50_346
  end

  it 'finds the total fuel required including fuel' do
    expect(rocket.find_total_fuel_required_including_fuel_for_fuel).to eq 5_026_151
  end
end
