module Dontfile
  class Client
    module Pages
      def page(path : String, options = nil) : Dontfile::Page
        result = get(json_resource_path(path))
        Dontfile::Page.from_json(result)
      end

      def replace_page_content(page_path : String, content : String = "") : Dontfile::Page
        result = patch(json_resource_path(page_path), body: {"page" => {"content" => content}}.to_json)
        Dontfile::Page.from_json(result)
      end

      def append_page_content(page_path : String, content : String)
        current_content = Dontfile::Page.from_path(page_path).content.to_s
        result = patch(json_resource_path(page_path), body: {"page" => {"content" => current_content + content}}.to_json)
        Dontfile::Page.from_json(result)
      end

      def delete_page_file(page_path : String) : Dontfile::Page
        result = delete("/delete_file.json", params: {"url" => page_path})
        Dontfile::Page.from_json(result)
      end

      private def json_resource_path(path : String) : String
        "#{sanitize_path(path)}.json"
      end

      private def sanitize_path(path : String) : String
        path = path.strip
        path = path.insert(0, '/') unless path.starts_with? '/'

        path
      end
    end
  end
end
