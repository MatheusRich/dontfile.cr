require "option_parser"
require "../page"

module Dontfile::Command
  module WritePage
    def self.run(args)
      config = parse_args(args)
      print "Writing... "

      if config.writing_mode.append?
        Dontfile::Client.new.append_page_content(config.page_path, config.page_content)
      elsif config.writing_mode.prepend?
        Dontfile::Client.new.prepend_page_content(config.page_path, config.page_content)
      else
        Dontfile::Client.new.replace_page_content(config.page_path, config.page_content)
      end

      puts "Done!"
    rescue e
      STDERR.puts "ERROR: #{e}"
    end

    private def self.parse_args(args) : Config
      config = Config.new

      OptionParser.parse(args) do |parser|
        parser.banner = "Usage: dontfile write|w PAGE_PATH PAGE_CONTENT [opts].\n\nOptions:"

        parser.on("-h", "--help", "Show this help") { puts parser; exit }

        parser.on("-F", "--force", "Fully replaces the content of the page") do
          config.writing_mode = Config::WritingMode::Replace
        end

        parser.on("-a", "--append", "Adds new content to the end of the current page's content") do
          config.writing_mode = Config::WritingMode::Append
        end

        parser.on("-p", "--prepend", "Adds new content to the beginning of the current page's content") do
          config.writing_mode = Config::WritingMode::Prepend
        end

        parser.unknown_args do |unknown_args, _|
          config.page_path = unknown_args.first? || ""
          config.page_content = unknown_args[1]? || ""

          raise Dontfile::Errors::InternalError.new "Argument 'PAGE_PATH' is missing.\n#{parser}" if config.page_path.empty?
        end

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

      config
    end

    private class Config
      enum WritingMode
        Append
        Prepend
        Replace
      end

      property page_path : String
      property page_content : String
      property writing_mode : WritingMode

      def initialize(@page_path = "", @page_content = "", @writing_mode = WritingMode::Append); end
    end
  end
end
