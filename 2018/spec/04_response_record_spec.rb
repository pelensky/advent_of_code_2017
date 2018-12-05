require '04_response_record'

RSpec.describe ResponseRecord do
  subject(:response_record) { described_class.new }

  it 'transforms the data' do
    data = [
      '[1518-03-23 00:04] Guard #2267 begins shift',
      '[1518-03-23 01:24] falls asleep',
      '[1518-03-23 02:26] wakes up'
    ]
    result = {
      '1518-03-23' => {
        guard: 2267,
        begin_shift: 04,
        asleep: [84],
        awake: [146]
      }
    }

    expect(response_record.transform(data)).to eq result

  end

end
