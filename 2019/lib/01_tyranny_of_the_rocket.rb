# frozen_string_literal: true

require 'utils'

class TyrannyOfTheRocket
  def find_total_fuel_required
    modules = Utils.read_integers_from_file('./input/01_tyranny_of_the_rocket.txt')
    mass = modules.map { |individual| find_fuel_required(individual) }
    sum(mass)
  end

  def find_total_fuel_required_including_fuel_for_fuel
    modules = Utils.read_integers_from_file('./input/01_tyranny_of_the_rocket.txt')
    mass = modules.map { |individual| find_fuel_required_including_fuel_for_fuel(individual) }
    sum(mass)
  end

  def find_fuel_required(mass)
    fuel_required = (mass / 3) - 2
    fuel_required.positive? ? fuel_required : 0
  end

  def find_fuel_required_including_fuel_for_fuel(mass)
    fuel = []
    fuel_required = find_fuel_required(mass)
    fuel << fuel_required
    until fuel_required <= 0
      fuel_required = find_fuel_required(fuel_required)
      fuel << fuel_required
    end
    sum(fuel)
  end

  def sum(numbers)
    numbers.inject(0, :+)
  end
end
