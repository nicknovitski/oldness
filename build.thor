
class Gems < Thor
  desc "validate", "Test gemspec"
  def validate
    raise Exception unless gemspec.validate
  end

  desc "build", "Build gem locally"
  def build
    invoke :validate
    system "gem build #{gemspec.name}.gemspec"
    FileUtils.mkdir_p "pkg"
    FileUtils.mv "#{gemspec.name}-#{gemspec.version}.gem", "pkg"
  end

  desc "clean", "Delete generated gem files"
  def clean
    FileUtils.rm_rf "pkg"
  end

  desc "install", "Build and install gem locally"
  def install
    invoke :build
    system "gem install pkg/#{gemspec.name}-#{gemspec.version}"
  end

  desc "github", "Push to Github"
  def github
    system "git push origin : --tags"
  end

  desc "rubygems", "Push to Rubygems"
  def rubygems
    invoke :build
    system "gem push pkg/#{gemspec.name}-#{gemspec.version}.gem"
  end

  desc "publish", "Push to Github and Rubygems"
  def publish
    invoke :github
    invoke :rubygems
  end

  no_tasks do
    def gemspec
      @gemspec ||= eval(File.read(Dir["*.gemspec"].first))
    end
  end
end