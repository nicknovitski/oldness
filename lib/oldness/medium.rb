require 'date'
require 'oldness/work'

module Oldness
  class Medium
    @descendents = []
    def self.ranges(args={})
      current_date = args[:when] ? args[:when] : Date.today
      span = (current_date-first.date)
      unit = span/81
      ranges = {5 => (first.date..current_date-27*unit),
                4 => (current_date-27*unit..current_date-9*unit),
                3 => (current_date-9*unit..current_date-3*unit),
                2 => (current_date-3*unit..current_date-unit),
                1 => (current_date-unit..current_date)}
      if args[:formatted]
        f_ranges = ""
        ranges.each do |stars, range|
          f_ranges += ("*" * stars) + (" " * (5-stars)) + ": #{range}\n"
        end
        f_ranges.chomp
      else
        ranges
      end
    end

    def self.rate(work_date, args={})
      work_date = parse_date(work_date)

      formatted = args[:formatted]
      args[:formatted] = nil
      rating = ranges(args).find {|key, range| range.cover?(work_date)}[0]

      if formatted
        "*" * rating
      else
        rating
      end
    end

    def self.began(date, args={})
      @first = Work.new(date, :title => args[:with], :by => args[:by])
      def self.first
        @first
      end
    end

    def self.list(opts={})
      if opts[:formatted]
        @descendents.collect(&:to_s).sort.inject("") { |l, c| l + c.downcase.sub("oldness::", "")+"\n" }
      else
        @descendents
      end
    end

    def self.inherited(child)
      @descendents << child
    end

    private
    def self.parse_date(date)
      begin
        date_info = date.split("-")
      rescue NoMethodError
        return date
      end

      if date_info[0].downcase.end_with?('bc')
        date_info[0][-2..-1] = ""
        date_info[0].insert(0,'-')
      end

      Date.new(*date_info.map {|v| v.to_i})
    end
  end

  class Literature < Medium
    began Date.new(-1300), :with => "The Epic of Gilgamesh"
  end

  class Philosophy < Medium
    began Date.new(-800), :with => "The Upanishads"
  end
  Religion = Philosophy # now that's what I call opinionated software

  class SciFi < Medium
    began Date.new(1620), :with => "Somnium", :by => "Johannes Kepler"
  end

  class Novel < Medium
    began Date.new(1010), :with => "Tale of Genji", :by => "Murasaki Shikibu"
  end
  Book = Novel

  class Film < Medium
    began Date.new(1894, 2, 5), :by => "Jean Le Roy"
  end
  Movie = Film

  class Comic < Medium
    began Date.new(1837), :with => "Histoire de M. Vieux Bois", :by => "Rodolphe Topffer" # todo: Töpffer
  end
  Manga = Comic

  class Videogame < Medium
    began Date.new(1952, 7, 1), :with => "Draughts", :by => "Christopher Strachey"
  end

  class History < Medium
    began Date.new(-411), :with => "History of the Pelopnnesian War", :by => "Thucydides"
  end

  class Animation < Medium
    began Date.new(1906, 4, 6), :with => "Humorous Phases of Funny Faces", :by => "J. Stuart Blackton"
  end
  Cartoon = Animation
  Anime = Animation

  class Rpg < Medium
    began Date.new(1974), :with => "Dungeons & Dragons", :by => "Gary Gygax and David Arneson"
  end

  class Boardgame < Medium
    began Date.new(-3500), :with => "Senet"
  end

end
