require 'date'

def oldness_rating(work_date, start_date)
  current_date=Date.today
  raise ArgumentError if work_date > current_date or work_date < start_date
  oldness_ranges(start_date).find {|key, range| range.cover?(work_date)}[0]
end

def oldness_ranges(start_date)
  current_date = Date.today
  span = (current_date-start_date)
  unit = span/81
  {5 => (start_date..current_date-27*unit),
   4 => (current_date-27*unit..current_date-9*unit),
   3 => (current_date-9*unit..current_date-3*unit),
   2 => (current_date-3*unit..current_date-unit),
   1 => (current_date-unit..current_date)}
end