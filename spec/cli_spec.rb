require 'spec_helper'

module Oldness
  describe "oldness" do
    before :all do
      Dir.chdir("../bin")
    end

    describe "rating" do
      it "calls the rating method of the named Medium class with :formatted=>true"
    end

    context "range" do
      it "calls the range method of the named Medium class with :formatted=>true"
    end

    context "first" do
      it "prints the string formatting of the Work object stored under the first method of the appropriate Medium class"
    end
  end
end