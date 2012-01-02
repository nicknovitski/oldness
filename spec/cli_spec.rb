require 'rspec'
require_relative '../lib/oldness'

describe "oldness" do
  before :all do
    Dir.chdir("../bin")
  end

  describe "rating" do

    def cli_rating(string)
      `./oldness rating #{string}`
    end
    context "followed by a medium name and a date" do
      it "can rate a work of literature" do
        cli_rating('literature 2001').should == "*\n"
        cli_rating('literature 1889-4-26').should == "***\n"
        cli_rating('literature 100BC').should == "*****\n"
        cli_rating('literature 1100BC').should == "*****\n"
        cli_rating('literature 1100bc-12-25').should == "*****\n"
      end
      it "can rate a work of philosophy or religion" do
        cli_rating('philosophy 1700').should == "***\n"
        cli_rating('religion 1911').should == "**\n"
      end
      it "can rate a work of science fiction" do
        cli_rating("sci-fi 1965").should == "****\n"
      end
      it "can rate a novel or book" do
        cli_rating('novel 1900').should == "****\n"
        cli_rating('book 1900').should == "****\n"
      end
      it "can rate a film or movie" do
        cli_rating('film 1900').should == "*****\n"
        cli_rating("movie 1900").should == "*****\n"
      end
      it "can rate a comic or manga" do
        cli_rating("comic 1970").should == "****\n"
        cli_rating("manga 1970").should == "****\n"
      end
      it "can rate a videogame" do
        cli_rating("videogame 2005-4-1").should == "****\n"
      end
      it "can rate a history" do
        cli_rating("history 1922-4-1").should == "***\n"
        #non-fiction?  (auto)biography?
      end
      it "can rate a cartoon, animation or anime" do
        cli_rating("cartoon 2000").should == "****\n"
        cli_rating("animation 2000").should == "****\n"
        cli_rating("anime 2000").should == "****\n"
      end
    end
    context "followed by a pair of dates" do
      it "understands the format YYYY" do
        pending
        cli_rating("1300BC 1889").should == "***\n"
      end
      it "understands the format YYYY-MM" do
        pending
        cli_rating("1906-4 2000-1").should == "****\n"
      end
      it "understands the format YYYY-MM-DD" do
        pending
        cli_rating("1951-5-4 2005-4-1").should == "****\n"
      end
    end
  end

  context "range" do
    context "followed by the name of a medium" do
      it "knows the ranges for literature" do
        result = `./oldness range literature`
        range = Literature.ranges
        expected_result = "*    : #{range[1]}\n**   : #{range[2]}\n***  : #{range[3]}\n**** : #{range[4]}\n*****: #{range[5]}\n"
        result.should == expected_result
      end
      it "knows the ranges for philosophy"
    end
    context "followed by a date" do
      it "understands the format YYYY" do
        pending
        result = `./oldness range 1900`
        range = Oldness::ranges('1900')
        expected_result = "*    : #{range[1]}\n**   : #{range[2]}\n***  : #{range[3]}\n**** : #{range[4]}\n*****: #{range[5]}\n"
        result.should == expected_result
      end
      it "understands the format YYYY-MM" do
        pending
        result = `./oldness range 1500BC-3`
        range = Oldness::ranges('1500BC-3')
        expected_result = "*    : #{range[1]}\n**   : #{range[2]}\n***  : #{range[3]}\n**** : #{range[4]}\n*****: #{range[5]}\n"
        result.should == expected_result
      end
      it "understands the format YYYY-MM-DD" do
        pending
        result = `./oldness range 1986-11-20`
        range = Oldness::ranges('1986-11-20')
        expected_result = "*    : #{range[1]}\n**   : #{range[2]}\n***  : #{range[3]}\n**** : #{range[4]}\n*****: #{range[5]}\n"
        result.should == expected_result
      end
    end
  end

  context "first" do
    def first(medium)
      `./oldness first #{medium}`
    end
    it "tells you about the very first instance of a given work" do
      first('literature').should == "The Epic of Gilgamesh (1300BC)\n"
      #first('')
    end
  end
end
