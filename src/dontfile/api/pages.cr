module Dontfile
  class Client
    module Pages
      def page(path : String, options = nil) : Dontfile::Page
        result = get(json_resource_path(path))
        Dontfile::Page.from_json(result)
      end

      def update_page_content(page_path : String, content : String) : Dontfile::Page
        result = patch(json_resource_path(page_path), body: {"page" => {"content" => content}}.to_json)
        Dontfile::Page.from_json(result)
      end

      def append_page_content
        # TODO
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
