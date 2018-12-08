require 'utils'

class ResponseRecord
  ONE_HOUR = 60

  def transform(data)
    records = {}
    data.each do |record|
      date_and_time = record.split(']')[0]
      info = record.split(']')[1].strip!
      date = date_and_time.split(' ')[0][1..-1]
      time_string = date_and_time.split(' ')[1]
      converted_date = convert_time(time_string, date)[0]
      converted_time = convert_time(time_string, date)[1]

      records = add_guard(records, converted_date, converted_time, info) if info.include?('Guard')
      records = add_sleep_time(records, converted_date, converted_time) if info.include?('asleep')
      records = add_awake_time(records, converted_date, converted_time) if info.include?('wakes')
    end
    records
  end

  def add_sleep_data(record)
    record[:time_asleep] = find_sleep_time(record)
    record[:minutes_asleep] = find_sleep_minutes(record)
    record
  end

  def find_sleepiest_guard(records)
    transformed_records = transform_and_add_sleep_data(records)
    guard_data = {}
    transformed_records.each do |_k, v|
      guard = v[:guard]
      guard_data[guard] = { time_asleep: 0, minutes_asleep: [] } unless guard_data[v[:guard]]
      guard_data[guard][:time_asleep] += v[:time_asleep]
      guard_data[guard][:minutes_asleep] += v[:minutes_asleep]
      guard_data[guard][:minutes_asleep].sort!
    end
    guard_data.each do |k, v|
      guard_data[k][:most_likely_minute] = guard_data[k][:minutes_asleep].max_by { |i| guard_data[k][:minutes_asleep].count(i) }
    end
    guard_data
  end

  def find_sleepiest_guard_and_minute(records)
    guard_data = find_sleepiest_guard(records)
    guard = guard_data.max_by {|k, v| v[:time_asleep] }
    guard[0] * guard[1][:most_likely_minute]
  end

  def solve_q1(filename)
    records = Utils.read_words_from_file(filename)
    find_sleepiest_guard_and_minute(records)
  end

  private

  def convert_time(time_stamp, date)
    split_date = date.split('-')
    y = split_date[0]
    m = split_date[1]
    d = split_date[2].to_i
    hour = time_stamp.split(':')[0].to_i
    minute = time_stamp.split(':')[1].to_i
    if hour == 23
      ["#{y}-#{m}-#{d + 1}", -(ONE_HOUR - minute)]
    else
      ["#{y}-#{m}-#{d}", (ONE_HOUR * hour) + minute]
    end
  end

  def add_guard(records, date, time, info)
    guard = info.split(' ')[1][1..-1].to_i
    if records[date]
      records[date][:guard] = guard
    else
      records[date] = { guard: guard }
    end
    records[date][:begin_shift] = time
    records
  end

  def add_sleep_time(records, date, time)
    records = add_date_entry(records, date)
    if records[date][:asleep]
      records[date][:asleep] << time
    else
      records[date][:asleep] = [time]
    end
    records[date][:asleep].sort!
    records
  end

  def add_awake_time(records, date, time)
    records = add_date_entry(records, date)
    if records[date][:awake]
      records[date][:awake] << time
    else
      records[date][:awake] = [time]
    end
    records[date][:awake].sort!
    records
  end

  def add_date_entry(records, date)
    records[date] = {} unless records[date]
    records
  end

  def find_sleep_time(record)
    minutes_asleep = 0
    if record[:asleep]
      record[:asleep].each_with_index do |sleep, index|
        minutes_asleep += record[:awake][index] - sleep
      end
    end
    minutes_asleep
  end

  def find_sleep_minutes(record)
    asleep_minutes = []
    record[:asleep].each_with_index do |sleep, index|
      asleep_minutes << (sleep...record[:awake][index]).to_a
    end
    asleep_minutes.flatten
  end

  def transform_and_add_sleep_data(records)
    transformed = transform(records)
    transformed.each do |k, v|
      transformed[k] = add_sleep_data(v)
    end
    transformed
  end
end
