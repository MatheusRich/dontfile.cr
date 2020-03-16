require "option_parser"

OptionParser.parse do |parser|
  parser.banner = "Usage: dontfile [arguments]"
  parser.on("-h", "--help", "Show this help") { puts parser }
  parser.on("-r PAGE", "--read PAGE", "Read desired PAGE") { |page| puts "Reading #{page}" }
  parser.on("-w PAGE", "--write PAGE", "Write on desired PAGE. It appends the current page content") { |page| puts "Writing on #{page}" }
  parser.on("-F", "--force", "Overrides the content of the page") { puts "Overriding..." }
  parser.on("-t", "--text-only", "Get only page text") { puts "Only text..." }
  parser.on("-f", "--file-only", "Get only page file") { puts "Only file..." }
  parser.on("-z", "--zip", "Get page content zipped") { puts "Zipping..." }
  parser.missing_option do |flag|
    STDERR.puts "ERROR: #{flag} is missing something."
    STDERR.puts
    STDERR.puts parser
    exit(1)
  end
  parser.invalid_option do |flag|
    STDERR.puts "ERROR: #{flag} is not a valid option."
    STDERR.puts
    STDERR.puts parser
    exit(1)
  end
end

# default action is --read --only-text
