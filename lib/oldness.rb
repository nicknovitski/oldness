require 'date'

def date_from(string)
  date_info = string.split("-")

  if date_info[0].downcase.end_with?('bc')
    date_info[0][-2..-1] = ""
    date_info[0].insert(0,'-')
  end

  Date.new(*date_info.map {|v| v.to_i})
end

def date_of_first_work(medium)
  case medium
    when 'novel', 'book' then Date.new(1010) # Tale of Genji
    when 'film', 'movie' then Date.new(1894, 2, 5) # Jean Le Roy's "marvellous cinematograph"
    when 'comic', 'manga' then Date.new(1837) # Histoire de M. Vieux Bois
    when 'videogame' then Date.new(1951, 5, 4) # NIMROD
    when 'history' then Date.new(-411) # end of Thucydides' history
    when 'literature' then Date.new(-1300) # Epic of Gilgamesh
    when 'philosophy', 'religion' then Date.new(-800) # The Upanishads
    when 'animation', 'cartoon', 'anime'  then Date.new(1906, 4, 6) #Humorous Phases of Funny Faces
    else raise Exception
  end
end

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