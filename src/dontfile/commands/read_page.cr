require "../page"

module Dontfile::Command
  module ReadPage
    def self.run(page_path : String)
      puts Dontfile::Page.from_path(page_path).content
    end
  end
end
