require '07_sum_of_its_parts'

RSpec.describe SumOfItsParts do
  subject(:sum_of_its_parts) { described_class.new }

  instructions = {
    'A' => %w[B D],
    'B' => ['E'],
    'C' => %w[A F],
    'D' => ['E'],
    'F' => ['E']
  }

  it 'transforms the data' do
    input = ['Step C must be finished before step A can begin.',
             'Step C must be finished before step F can begin.',
             'Step A must be finished before step D can begin.',
             'Step A must be finished before step B can begin.',
             'Step B must be finished before step E can begin.',
             'Step D must be finished before step E can begin.',
             'Step F must be finished before step E can begin.']
    expect(sum_of_its_parts.transform(input)).to eq instructions
  end

  it 'sorts the parts' do
    expect(sum_of_its_parts.sort(instructions)).to eq 'CABDFE'
  end


end
