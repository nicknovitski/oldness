require 'date'

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

class Literature < Medium # The Epic of Gilgamesh
  starts_from Date.new(-1300)
end

class Philosophy < Medium # The Upanishads
  starts_from Date.new(-800)
end

class Religion < Medium
  starts_from Date.new(-800)
end

class SciFi < Medium # Somnium, Johannes Kepler
  starts_from Date.new(1620)
end

class Novel < Medium # Tale of Genji, Murasaki Shikibu
  starts_from Date.new(1010)
end

class Book < Medium
  starts_from Date.new(1010)
end

class Film < Medium # Untitled, Jean Le Roy
  starts_from Date.new(1894, 2, 5)
end

class Movie < Medium
  starts_from Date.new(1894, 2, 5)
end

class Comic < Medium # Histoire de M. Vieux Bois, Rodolphe Töpffer
  starts_from Date.new(1837)
end

class Manga < Medium
  starts_from Date.new(1837)
end

class Videogame < Medium
  starts_from Date.new(1951, 5, 4) # NIMROD, Ferranti International plc
end

class History < Medium
  starts_from Date.new(-411) # History of the Pelopennisian War, Thucydides
end

class Animation < Medium # Humorous Phases of Funny Faces, J. Stuart Blackton
  starts_from Date.new(1906, 4, 6)
end

class Cartoon < Medium
  starts_from Date.new(1906, 4, 6)
end

class Anime < Medium
  starts_from Date.new(1906, 4, 6)
end

#todo: merge duplicates