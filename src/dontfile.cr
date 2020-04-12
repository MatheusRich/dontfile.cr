require "./**"

# TODO: Write documentation for `Dontfile`
module Dontfile
  VERSION = "0.1.0"
end

Dontfile::Command.run(ARGV)
