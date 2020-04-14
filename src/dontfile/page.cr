require "json"

module Dontfile
  class Page
    JSON.mapping(
      url: String,
      content: String?,
    )

    def self.from_path(path : String)
      Dontfile::Client.new.page(path) # TODO: Maybe the client should be a singleton
    end
  end
end
