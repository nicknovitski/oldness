require 'spec_helper'

module Oldness
  describe Work do
    context "BC, year only, no title, no credit" do
      let(:w) {Work.new(Date.new(-1000))}
      describe "#date" do
        it "returns the date object" do
          w.date.should == Date.new(-1000)
        end
      end
      describe "#by" do
        it "defaults to 'Unknown'" do
          w.by.should == "Unknown"
        end
      end
      describe "#title" do
        it "defaults to 'Untitled'" do
          w.title.should == "Untitled"
        end
      end
      describe "#to_s" do
        it "Uses 'BC' instead of negative years" do
          "#{w}".should == "Untitled (1000BC)"
        end
      end
    end
    context "Year and Month, Title, no author" do
      let(:w) {Work.new(Date.new(1974, 2), :title => "Dungeons and Dragons")}
      describe "#to_s" do
        it "formats the month as a word" do
          "#{w}".should == "Dungeons and Dragons (February 1974)"
        end
      end
    end
    context "Year, month and day, title and author" do
      let(:w) {Work.new(Date.new(1906, 4, 6), :title => "Humorous Phases of Funny Faces", :by => "J. Stuart Blackton")}
      describe "#to_s" do
        it "includes the day of the month" do
          "#{w}".should == "#{w.title} (April 6, 1906), by #{w.by}"
        end
      end
    end
  end

end