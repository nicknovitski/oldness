require 'spec_helper'
require 'stringio'

module Oldness
  describe CLI do
    before :each do
      @io = StringIO.new
      $stdout = @io
    end
    let(:cli) {CLI.new}

    def compare(method, medium, date=nil)
      cli.invoke(method, [medium, date].compact)
      args = [method, date]
      args << {:formatted => true} unless method == :first
      @io.string.should == eval(medium.capitalize).send(*args.compact).to_s + "\n"
    end


    describe "rate" do
      it "calls the rating method of the named Medium class with :formatted=>true" do
        compare(:rate, "film", "1999")
      end
    end

    describe "range" do
      it "calls the range method of the named Medium class with :formatted=>true" do
        compare(:ranges,"film")
      end
    end

    describe "first" do
      it "calls the first method of named Medium class" do
        compare(:first, "film")
      end
    end

    describe "media" do
      it "lists all subclasses of Medium in the object space" do
        list = []
        ObjectSpace.each_object(Class) do |c|
          next unless c.superclass == Medium
          list << c
        end

        cli.invoke(:media)
        @io.string.should == list.collect(&:to_s).sort.inject("") { |l, c| l + c.downcase.sub("oldness::", "")+"\n" }
      end
    end
  end
end