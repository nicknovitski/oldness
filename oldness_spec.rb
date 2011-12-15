require 'rspec'
require_relative 'oldness'
require 'date'

describe "::rating" do
  let(:start_date) {Date.today - 162}
  it "should recognize one-stars" do
    oldness_rating(Date.today, start_date).should == 1
    oldness_rating(Date.today-1, start_date).should == 1
  end
  it "recognizes two-stars" do
    test_range(2, 5, 2)
  end
  it "recognizes three-stars" do
    test_range(6, 17, 3)
  end
  it "recognizes four-stars" do
    test_range(18, 53, 4)
  end
  it "recognizes five-stars" do
    test_range(54, 162, 5)
    oldness_rating(start_date, start_date).should == 5
  end
  it "throws an exception when the first parameter is not between the second and the present day" do
    expect {oldness_rating(Date.today+1, start_date)}.to raise_error(ArgumentError)
    expect {oldness_rating(Date.new(1995), start_date)}.to raise_error(ArgumentError)
  end
end

describe "ranges" do
  it "should return a hash of date-ranges indexed by star ration" do
    result = oldness_ranges(Date.today-162)
    result[1].should == (Date.today-2..Date.today)
    result[2].should == (Date.today-6..Date.today-2)
    result[3].should == (Date.today-18..Date.today-6)
    result[4].should == (Date.today-54..Date.today-18)
    result[5].should == (Date.today-162..Date.today-54)
  end
end

def test_range(at_least, at_most, rating)
  at_least.upto(at_most) do |days_ago|
    oldness_rating(Date.today-days_ago, start_date).should == rating
  end
end