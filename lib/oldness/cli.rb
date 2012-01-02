require 'thor'

def parse_date(string)
  date_info = string.split("-")

    if date_info[0].downcase.end_with?('bc')
      date_info[0][-2..-1] = ""
      date_info[0].insert(0,'-')
    end

    Date.new(*date_info.map {|v| v.to_i})
end

def get_class(medium)
  eval medium.split('-').collect(&:capitalize).inject(:+)
end

class CLI < Thor

  desc "rating MEDIUM DATE", "give a star rating of oldness for a work in MEDIUM made on DATE"
  def rating(medium, date)
    print "*" * get_class(medium).rate(parse_date(date)) + "\n"
  end

  desc "range MEDIUM", "show what dates fall under what star ratings for a work in MEDIUM"
  def range(medium)
    range = get_class(medium).ranges
    print "*    : #{range[1]}\n**   : #{range[2]}\n***  : #{range[3]}\n**** : #{range[4]}\n*****: #{range[5]}\n"
  end

  desc "first MEDIUM", "print the first work in MEDIUM"
  def first(medium)
    print "#{get_class(medium).first}\n"
  end
end
