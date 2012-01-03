require 'thor'

module Oldness

  class CLI < Thor

    desc "rating MEDIUM DATE", "give a star rating of oldness for a work in MEDIUM made on DATE"
    def rating(medium, date)
      print "#{get_class(medium).rate(date, :formatted => true)}\n"
    end

    desc "range MEDIUM", "show what dates fall under what star ratings for a work in MEDIUM"
    def range(medium)
      print "#{get_class(medium).ranges(:formatted=>true)}\n"
    end

    desc "first MEDIUM", "print the first work in MEDIUM"
    def first(medium)
      print "#{get_class(medium).first}\n"
    end

    desc "list", "print defined mediums which can be used in other commands"
    def list
      print Oldness::media.inject("") { |l, c| l + c.to_s.sub("Oldness::", "")+"\n"}
    end

    no_tasks do
      def get_class(medium)
        eval("Oldness::" + medium.split('-').collect(&:capitalize).inject(:+))
      end
    end
  end
end