module Oldness
  class Work
    def by
      @by ? @by : "Unknown"
    end
    def title
      @title ? @title : "Untitled"
    end
    attr_accessor :date
    def initialize(date, args={})
      @date, @title, @by = date, args[:title], args[:by]
    end
    def to_s
      if date.yday == 1
        if date.year < 0
          f_date = (date.year * -1).to_s + "BC"
        else
          f_date = "#{date.year}"
        end
      elsif date.mday == 1
        f_date = date.strftime("%B %Y")
      else
        f_date = date.strftime("%B %-d, %Y")
      end
      str = "#{title} (#{f_date})"
      if @by
        str += ", by #{@by}"
      end
      str
    end
  end
end