class Medium
  def self.ranges(args={})
    current_date = args[:when] ? args[:when] : Date.today
    span = (current_date-start_date)
    unit = span/81
    {5 => (start_date..current_date-27*unit),
     4 => (current_date-27*unit..current_date-9*unit),
     3 => (current_date-9*unit..current_date-3*unit),
     2 => (current_date-3*unit..current_date-unit),
     1 => (current_date-unit..current_date)}
  end

  def self.rate(work_date, args={})
    ranges(args).find {|key, range| range.cover?(work_date)}[0]
  end

  def self.starts_from(date)
    @start_date = date
  end
  def self.start_date
    @start_date
  end
end
