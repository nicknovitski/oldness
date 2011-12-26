require 'rspec'

describe "'oldness' command" do
  before :all do
    Dir.chdir("../bin")
  end
  let(:command) {'./oldness'}
  context "followed by the 'rating' sub-command" do
    let(:sub_command) {'rating'}
    context "followed by a medium name and a date" do
      it "can rate a work of literature" do
        `#{command} #{sub_command} literature 2001`.should == "*"
        `./oldness rating literature 1889-4`.should == "***"
        `./oldness rating literature 1889-4-26`.should == "**"
        `./oldness rating literature -100`.should == "*****"
        `./oldness rating literature -100-12-25`.should == "*****"
      end
      it "can rate a work of philosophy or religion" do
        `#{command} #{sub_command} philosophy 1700`.should == '****'
        `#{command} #{sub_command} religion 1911`.should == '**'
      end
      it "knows the ranges for novels and books"
      it "knows the ranges for films and movies"
      it "knows the ranges for comics and manga"
      it "knows the ranges for videogames"
      it "knows the ranges for histories"
      it "knows the ranges for cartoons, animation and anime"
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
