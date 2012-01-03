require 'spec_helper'

module Oldness
  describe "oldness" do
    before :all do
      Dir.chdir("../bin")
    end

    describe "rating" do
      it "calls the rating method of the named Medium class with :formatted=>true"
    end

    describe "range" do
      it "calls the range method of the named Medium class with :formatted=>true"
    end

    describe "first" do
      it "prints the string formatting of the Work object stored under the first method of the appropriate Medium class"
    end

    describe "list" do
      it "lists all subclasses of Medium in the object space" do
        list = []
        ObjectSpace.each_object(Class) do |c|
          next unless c.superclass == Medium
          list << c
        end
        `./oldness list`.should == list.inject("") { |l, c| l + c.to_s.sub("Oldness::", "")+"\n" }
      end
    end
  end
end