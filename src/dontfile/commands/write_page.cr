require "../page"

module Dontfile::Command
  module WritePage
    def self.run(page_path : String, content : String, args)
      puts "Writing..."

      if args[:force]
        Dontfile::Client.new.replace_page_content(page_path, content)
      else
        Dontfile::Client.new.append_page_content(page_path, content)
      end

      puts "Done!"
    end
  end
end
