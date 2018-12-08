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

  it 'iterates and finds the minutes asleep per night' do
    input = {
      asleep: [5, 30],
      awake: [25, 55],
      begin_shift: 0,
      guard: 1
    }
    result = {
      asleep: [5, 30],
      awake: [25, 55],
      begin_shift: 0,
      guard: 1,
      time_asleep: 45,
      minutes_asleep: (5...25).to_a + (30...55).to_a
    }
    expect(response_record.add_sleep_data(input)).to eq result
  end

  it 'finds the guard most likely to be asleep' do
    data = [
      '[1518-11-01 00:00] Guard #10 begins shift',
      '[1518-11-01 00:05] falls asleep',
      '[1518-11-01 00:25] wakes up',
      '[1518-11-01 00:30] falls asleep',
      '[1518-11-01 00:55] wakes up',
      '[1518-11-01 23:58] Guard #99 begins shift',
      '[1518-11-02 00:40] falls asleep',
      '[1518-11-02 00:50] wakes up',
      '[1518-11-03 00:05] Guard #10 begins shift',
      '[1518-11-03 00:24] falls asleep',
      '[1518-11-03 00:29] wakes up',
      '[1518-11-04 00:02] Guard #99 begins shift',
      '[1518-11-04 00:36] falls asleep',
      '[1518-11-04 00:46] wakes up',
      '[1518-11-05 00:03] Guard #99 begins shift',
      '[1518-11-05 00:45] falls asleep',
      '[1518-11-05 00:55] wakes up',
    ]
    result = {
      10 => {
        time_asleep: 50,
        minutes_asleep: [
          5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20,
          21, 22, 23, 24, 24, 25, 26, 27, 28, 30, 31, 32, 33, 34, 35,
          36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50,
          51, 52, 53, 54
        ],
        most_likely_minute: 24
      },
      99 => {
        time_asleep: 30,
        minutes_asleep: [
          36, 37, 38, 39, 40, 40, 41, 41, 42, 42, 43, 43, 44, 44, 45,
          45, 45, 46, 46, 47, 47, 48, 48, 49, 49, 50, 51, 52, 53, 54
        ],
        most_likely_minute: 45
      }
    }

    expect(response_record.find_sleepiest_guard(data)).to eq result
  end

  it 'multiplies the id of the sleepiest guard by the minute' do
    data = [
      '[1518-11-01 00:00] Guard #10 begins shift',
      '[1518-11-01 00:05] falls asleep',
      '[1518-11-01 00:25] wakes up',
      '[1518-11-01 00:30] falls asleep',
      '[1518-11-01 00:55] wakes up',
      '[1518-11-01 23:58] Guard #99 begins shift',
      '[1518-11-02 00:40] falls asleep',
      '[1518-11-02 00:50] wakes up',
      '[1518-11-03 00:05] Guard #10 begins shift',
      '[1518-11-03 00:24] falls asleep',
      '[1518-11-03 00:29] wakes up',
      '[1518-11-04 00:02] Guard #99 begins shift',
      '[1518-11-04 00:36] falls asleep',
      '[1518-11-04 00:46] wakes up',
      '[1518-11-05 00:03] Guard #99 begins shift',
      '[1518-11-05 00:45] falls asleep',
      '[1518-11-05 00:55] wakes up',
    ]
    result = 10 * 24
    expect(response_record.find_sleepiest_guard_and_minute(data)).to eq result
  end

  it 'solvles the riddle' do
    filename = './input/04_response_record_input.txt'
    expect(response_record.solve_q1(filename)).to eq 8421
  end

end
