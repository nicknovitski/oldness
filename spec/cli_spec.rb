require 'rspec'

describe "'oldness' command" do
  before :all do
    Dir.chdir("../bin")
  end

  context "followed by the 'rating' sub-command" do

    def cli_rating(string)
      `./oldness rating #{string}`
    end
    context "followed by a medium name and a date" do
      it "can rate a work of literature" do
        cli_rating('literature 2001').should == "*\n"
        cli_rating('literature 1889-4-26').should == "***\n"
        cli_rating('literature -100').should == "*****\n"
        cli_rating('literature -100-12-25').should == "*****\n"
      end
      it "can rate a work of philosophy or religion" do
        cli_rating('philosophy 1700').should == "***\n"
        cli_rating('religion 1911').should == "**\n"
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
        cli_rating("videogame 2005-4-1").should == "***\n"
      end
      it "can rate a history" do
        cli_rating("history 1922-4-1").should == "**\n"
        #non-fiction?  (auto)biography?
      end
      it "can rate a cartoon, animation or anime" do
        cli_rating("cartoon 2000").should == "****\n"
        cli_rating("animation 2000").should == "****\n"
        cli_rating("anime 2000").should == "****\n"
      end
    end
    context "followed by a pair of dates" do
      it "understands the format YYYY"
      it "understands the format YYYY-MM"
      it "understands the format YYYY-MM-DD"
    end
  end

  context "followed by the 'range' sub-command" do
    context "followed by the name of a medium" do
      it "knows the ranges for literature"
      it "knows the ranges for philosophy"
    end
    context "followed by a date" do
      it "understands the format YYYY"
      it "understands the format MM-YYYY"
      it "understands the format MM-DD-YYYY"
    end
  end

  context "first" do
    it "tells you what it thinks the first instance of a passed medium was"
  end
end
