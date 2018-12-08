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
        begin_shift: 4,
        asleep: [84],
        awake: [146]
      }
    }
    expect(response_record.transform(data)).to eq result
  end

  it 'transforms multipllel dates and times' do
    data = [
      '[1518-11-01 00:55] wakes up',
      '[1518-11-01 00:00] Guard #1 begins shift',
      '[1518-11-01 00:05] falls asleep',
      '[1518-11-01 00:30] falls asleep',
      '[1518-11-01 23:58] Guard #2 begins shift',
      '[1518-11-02 00:40] falls asleep',
      '[1518-11-02 00:50] wakes up',
      '[1518-11-03 00:05] Guard #1 begins shift',
      '[1518-11-03 00:29] wakes up',
      '[1518-11-04 00:36] falls asleep',
      '[1518-11-04 00:46] wakes up',
      '[1518-11-03 00:24] falls asleep',
      '[1518-11-05 00:03] Guard #1 begins shift',
      '[1518-11-05 00:45] falls asleep',
      '[1518-11-05 00:55] wakes up',
      '[1518-11-01 00:25] wakes up',
      '[1518-11-04 00:02] Guard #2 begins shift',
    ]
    result = {
      '1518-11-1' => { asleep: [5, 30], awake: [25, 55], begin_shift: 0, guard: 1 },
      '1518-11-2' => { asleep: [40], awake: [50], begin_shift: -2, guard: 2 },
      '1518-11-3' => { asleep: [24], awake: [29], begin_shift: 5, guard: 1 },
      '1518-11-4' => { asleep: [36], awake: [46], begin_shift: 2, guard: 2 },
      '1518-11-5' => { asleep: [45], awake: [55], begin_shift: 3, guard: 1 }
    }
    expect(response_record.transform(data)).to eq result
  end

  it 'finds the total minutes asleep in a night' do
    input = {
      asleep: [5, 30],
      awake: [25, 55],
      begin_shift: 0,
      guard: 1
    }
    result = 20 + 25
    expect(response_record.find_sleep_time(input)).to eq result
  end

  it 'finds the exact minutes a guard was asleep' do
    input = {
      asleep: [5, 30],
      awake: [25, 55],
      begin_shift: 0,
      guard: 1
    }
    result = (5...25).to_a + (30...55).to_a
    expect(response_record.find_sleep_minutes(input)).to eq result
  end


end
