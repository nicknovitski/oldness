module Oldness
  module Version
    MAJOR = 0
    MINOR = 1
    PATCH = 1
  end

  VERSION = [Version::MAJOR, Version::MINOR, Version::PATCH].join('.')
end
