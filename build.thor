
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

class VersionBump < Thor
  desc "manual MAJOR MINOR PATCH", "Set version number to 'MAJOR.MINOR.PATCH'"
  def manual(major, minor, patch)
    version[0], version[1], version[2] = major, minor, patch
    update_version
  end

  desc "major", "Bump by a major version"
  def major
    version[0] += 1
    version[1] = 0
    version[2] = 0
    update_version
  end
  desc "minor", "Bump by a minor version"
  def minor
    version[1] += 1
    version[2] = 0
    update_version
  end
  desc "patch", "Bump by a patch version"
  def patch
    version[2] += 1
    update_version
  end
  no_tasks do
    def version
      $:.push File.expand_path("../lib", __FILE__)
      require 'oldness/version'
      Oldness::VERSION =~ /(\d+)\.(\d+)\.(\d+)/
      @version ||= [$1.to_i, $2.to_i, $3.to_i]
    end
    def update_version
      path = File.expand_path("./lib/oldness/version.rb")
      new_source = File.read(path).sub(/VERSION\s*=.*/, %Q{VERSION = "#{version.join('.')}"})
      File.open(path, 'w') { |f| f.puts new_source }
    end
  end
end