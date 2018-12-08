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

  private

  def convert_time(time_stamp, date)
    split_date = date.split('-')
    y = split_date[0]
    m = split_date[1]
    d = split_date[2].to_i
    hour = time_stamp.split(':')[0].to_i
    minute = time_stamp.split(':')[1].to_i
    if hour == 23
      ["#{y}-#{m}-#{d + 1}", -(60 - minute)]
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

end
