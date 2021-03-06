require 'spec_helper'

module Oldness
  describe Medium do
    def ranges_for(start_date, current_date = Date.today)
      span = (current_date-start_date)
      unit = span/81
      {5 => (start_date..current_date-27*unit),
       4 => (current_date-27*unit..current_date-9*unit),
       3 => (current_date-9*unit..current_date-3*unit),
       2 => (current_date-3*unit..current_date-unit),
       1 => (current_date-unit..current_date)}
    end
    def rating_for(start_date, work_date, current_date = Date.today)
      ranges_for(start_date, current_date).find {|key, range| range.cover?(work_date)}[0]
    end
    before :all do
      class RubyPrograms < Medium
        began Date.new(1979), :with=>"Hello World", :by => "Matz"
      end
      @ruby_ranges = ranges_for(Date.new(1979))
    end
    describe ".ranges" do
      it "returns a particular kind of hash" do
        RubyPrograms.ranges.should == @ruby_ranges
      end
      it "can take an argument for a particular date" do
        RubyPrograms.ranges(:when => Date.new(2009)).should == ranges_for(Date.new(1979), Date.new(2009))
      end
      it "can have formatted output instead" do
        RubyPrograms.ranges(:formatted => true).should == "*****: #{@ruby_ranges[5]}\n**** : #{@ruby_ranges[4]}\n***  : #{@ruby_ranges[3]}\n**   : #{@ruby_ranges[2]}\n*    : #{@ruby_ranges[1]}"
      end
    end
    describe ".rate" do
      it "rates oldest possible things as fives" do
        RubyPrograms.rate(Date.new(1979)).should == 5
      end
      it "rates newest possible things as ones" do
        RubyPrograms.rate(Date.today).should == 1
      end
      it "rates everything else properly" do
        [Date.new(2001), Date.new(2008), Date.new(2010)].each do |date|
          RubyPrograms.rate(date).should == rating_for(Date.new(1979), date)
        end
      end
      it "can take an argument for a particular date" do
        RubyPrograms.rate(Date.new(2010), :when => Date.new(2050)).should == 5
      end
      it "can have formatted output instead" do
        RubyPrograms.rate(Date.today, :formatted=>true).should == "*"
        RubyPrograms.rate(Date.new(2010), :when => Date.new(2050), :formatted => true).should == "*****"
      end
    end
    describe ".first" do
      it "returns a Work object with the attributes passed to .began" do
        RubyPrograms.first.title.should == "Hello World"
        RubyPrograms.first.by.should == "Matz"
        RubyPrograms.first.date.should == Date.new(1979)
        RubyPrograms.first.to_s.should == "Hello World (1979), by Matz"
      end
    end
    describe ".list" do
      def all_media
        classes = []
        ObjectSpace.each_object(Class) do |c|
          next unless c.superclass == Medium
          classes << c
        end
        classes
      end
      it "returns all the objects which inherit from Media" do
        all_media.each { |i| Medium.list.should include(i) }
        Medium.list.each { |i| all_media.should include(i) }
      end
      it "can have formatted output instead" do
        Medium.list(:formatted => true).should == Medium.list.collect(&:to_s).sort.inject("") { |l, c| l + c.downcase.sub("oldness::", "")+"\n" }
      end
    end
  end
end