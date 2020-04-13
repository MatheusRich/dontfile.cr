require "../page"
require "../errors"

module Dontfile::Command
  module ReadPage
    def self.run(args : Array(String))
      begin
        config = parse_args(args)
        page_path = config.page_path

        puts Dontfile::Page.from_path(page_path).content
      rescue e
        STDERR.puts "ERROR: #{e}"
      end
    end

    private def self.parse_args(args) : Config
      config = Config.new

      OptionParser.parse(args) do |parser|
        parser.banner = "Usage: dontfile [read|r] PAGE_PATH [opts].\n\nOptions:"

        parser.on("-h", "--help", "Show this help") { puts parser; exit }

        parser.unknown_args do |args, _|
          config.page_path = args.first? || ""

          raise Dontfile::Errors::InternalError.new "Argument 'PAGE_PATH' is missing.\n#{parser}" if config.page_path.empty?
        end

        parser.invalid_option do |flag|
          STDERR.puts "ERROR: #{flag} is not a valid option."
          STDERR.puts
          STDERR.puts parser
          exit(1)
        end
      end

      config
    end

    private class Config
      property page_path : String

      def initialize(@page_path = ""); end
    end
  end
end
