require 'thor'
require_relative 'rating.rb'

class CLI < Thor

  desc "rating MEDIUM DATE", "give a star rating of oldness for a work in MEDIUM made on DATE"
  def rating(medium, date)
    print "*" * oldness_rating(date_from(date), date_of_first_work(medium)) + "\n"
  end

  desc "range MEDIUM", "show what dates fall under what star ratings for a work in MEDIUM"
  def range(medium)
    range = oldness_ranges(date_of_first_work(medium))
    print "*    : #{range[1]}\n**   : #{range[2]}\n***  : #{range[3]}\n**** : #{range[4]}\n*****: #{range[5]}\n"
  end
end
