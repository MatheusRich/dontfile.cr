require "http/client"
require "json"
require "./error"
require "./client/pages"

module Dontfile
  class Client
    include Dontfile::Client::Pages

    BASE_URI        = URI.parse("http://dontfile.com")
    DEFAULT_HEADERS = HTTP::Headers{"content-type" => "application/json"}

    private getter http_client

    def initialize
      @http_client = HTTP::Client.new(BASE_URI)
    end

    def get(url : String, params = nil)
      response = http_client.get(url, params)
      handle_response(response)
    end

    def patch(url : String, body : String)
      response = http_client.patch(url, headers: DEFAULT_HEADERS, body: body)
      handle_response(response)
    end

    def delete(url : String, params : Hash(String, String))
      params = HTTP::Params.encode(params)
      response = http_client.delete("#{url}?#{params}", headers: DEFAULT_HEADERS)
      handle_response(response)
    end

    private def handle_response(response : HTTP::Client::Response)
      return response.body if response.success?

      raise Dontfile::Error.new("Bad HTTP Request. Status #{response.status_code}: #{response.status_message}")
    end
  end
end
