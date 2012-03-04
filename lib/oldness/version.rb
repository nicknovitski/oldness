module Oldness
  module Version
    MAJOR = 0
    MINOR = 1
    PATCH = 0
  end

  VERSION = [Version::MAJOR, Version::MINOR, Version::PATCH].join('.')
end
