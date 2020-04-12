require "../page"

module Dontfile::Command
  module ReadPage
    def self.run(args : Array(String))
      page_path = args.first?
      return puts "No page given" unless page_path

      puts Dontfile::Page.from_path(page_path).content
    end
  end
end
