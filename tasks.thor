
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

  no_tasks do
    def gemspec
      @gemspec ||= eval(File.read(Dir["*.gemspec"].first))
    end
  end
end

class VersionBump < Thor
  desc "manual MAJOR MINOR PATCH", "Set version number to 'MAJOR.MINOR.PATCH'"
  def manual(major, minor, patch)
    update_version(major, minor, patch)
  end

  desc "major", "Bump by a major version"
  def major
    invoke :manual, [version[:major] + 1, 0, 0]
  end
  desc "minor", "Bump by a minor version"
  def minor
    invoke :manual, [version[:major], version[:minor] + 1, 0]
  end
  desc "patch", "Bump by a patch version"
  def patch
    invoke :manual [version[:major], version[:minor], version[:patch] + 1]
  end

  no_tasks do
    def version
      $:.push File.expand_path("../lib", __FILE__)
      require 'oldness/version'
      @version ||= {:major=>Oldness::Version::MAJOR, :minor=>Oldness::Version::MINOR, :patch=>Oldness::Version::PATCH}
    end
    def update_version(major, minor, patch)
      path = File.expand_path("./lib/oldness/version.rb")
      new_source = File.read(path)
      new_source.sub!(/MAJOR\s*=.*/, %Q{MAJOR = #{major}}).sub!(/MINOR\s*=.*/, %Q{MINOR = #{minor}}).sub!(/PATCH\s*=.*/, %Q{PATCH = #{patch}})
      File.open(path, 'w') { |f| f.puts new_source }
    end
  end
end

class Publish < Thor
  desc "github", "Push changes to github"
  def github
    system "git push origin : --tags"
  end
  desc "gem", "Build gem and push it to rubygems"
  def gem
    confirm = ask "This will push whatever's in the working directory to rubygems. Are you SURE? Y/N"
    if confirm == "Y"
      invoke "gems:build"
      system "gem push pkg/#{gemspec.name}-#{gemspec.version}.gem"
    end
  end
  desc "all", "Push to both github and rubygems"
  def all
    invoke :github
    invoke :gem
  end

  no_tasks do
    def gemspec
      @gemspec ||= eval(File.read(Dir["*.gemspec"].first))
    end
  end
end

