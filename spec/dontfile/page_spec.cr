require "../spec_helper"

describe Dontfile::Page do
  describe ".from_json" do
    json = "{ \"url\": \"crystal\",  \"content\": \"Crystal FTW!\" }"
    page = Dontfile::Page.from_json(json)

    it "maps from json" do
      page.url.should eq "crystal"
      page.content.should eq "Crystal FTW!"
    end
  end

  describe ".from_path" do
    load_cassette("page-request") do
      path = "some-page"
      page = Dontfile::Page.from_path(path)

      it "searches the pages using the HTTP client" do
        page.url.should eq "some-page"
        page.content.should eq "It really searched!"
      end
    end
  end
end
