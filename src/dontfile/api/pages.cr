module Dontfile
  class Client
    module Pages
      def page(path : String, options = nil) : Dontfile::Page
        result = get(json_resource_path(path))
        Dontfile::Page.from_json(result)
      end

      private def json_resource_path(path : String) : String
        "/#{sanitize_path(path)}.json"
      end

      private def sanitize_path(path : String) : String
        path = path.strip
        path.insert(0, '/') unless path.starts_with? '/'

        path
      end
    end
  end
end
