require "http/client"
require "json"
require "./error"

module Dontfile
  class Client
    include Dontfile::Client::Pages

    BASE_URI = URI.parse("http://dontfile.com")

    private getter http_client

    def initialize
      @http_client = HTTP::Client.new(BASE_URI)
    end

    def get(url : String, params = nil)
      response = http_client.get(url, params)

      return handle_response(response)
    end

    private def handle_response(response : HTTP::Client::Response)
      return response.body if response.success?

      raise Dontfile::Error.new("Bad HTTP Request. Status #{response.status_code}: #{response.status_message}")
    end
  end
end
