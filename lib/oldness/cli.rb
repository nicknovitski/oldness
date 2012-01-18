require 'thor'

module Oldness

  class CLI < Thor

    desc "rate MEDIUM DATE", "give a star rating of oldness for a work in MEDIUM made on DATE"
    def rate(medium, date)
      print "#{get_class(medium).rate(date, :formatted => true)}\n"
    end
    map "rating" => "rate"

    desc "ranges MEDIUM", "show what dates fall under what star ratings for a work in MEDIUM"
    def ranges(medium)
      print "#{get_class(medium).ranges(:formatted=>true)}\n"
    end
    map "range" => "ranges"

    desc "first MEDIUM", "print the first work in MEDIUM"
    def first(medium)
      print "#{get_class(medium).first}\n"
    end

    desc "media", "List what mediums can be used in other commands"
    def media
      print "#{Medium.list(:formatted=>true)}"
    end
    map "mediums" => "media"
    map "list" => "media"

    no_tasks do
      def get_class(medium)
        eval("Oldness::" + medium.split('-').collect(&:capitalize).inject(:+))
      end
    end
  end
end