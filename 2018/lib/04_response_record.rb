class ResponseRecord
  ONE_HOUR = 60

  def transform(data)
    records = {}
    data.each do |record|
      date_and_time = record.split(']')[0]
      info = record.split(']')[1].strip!
      date = date_and_time.split(' ')[0][1..-1]
      time_string = date_and_time.split(' ')[1]
      time = convert_time(time_string)

      records = add_guard(records, date, time, info) if info.include?('Guard')
      records = add_sleep_time(records, date, time) if info.include?('asleep')
      records =add_awake_time(records, date, time) if info.include?('wakes')
    end
    records
  end

  private

  def convert_time(time_stamp)
    hour = time_stamp.split(':')[0].to_i
    minute = time_stamp.split(':')[1].to_i
    (ONE_HOUR * hour) + minute
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
    if records[date][:asleep]
      records[date][:asleep] << time
    else
      records[date][:asleep] = [time]
    end
    records
  end

  def add_awake_time(records, date, time)
    if records[date][:awake]
      records[date][:awake] << time
    else
      records[date][:awake] = [time]
    end
    records
  end
end
