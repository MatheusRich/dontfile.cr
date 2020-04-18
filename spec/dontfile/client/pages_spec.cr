require "../../spec_helper"

describe Dontfile::Client::Pages do
  client = Dontfile::Client.new

  describe "#page" do
    load_cassette("page-request") do
      path = "some-page"
      page = client.page(path)

      it "returns the requested page" do
        page.url.should eq "some-page"
        page.content.should eq "It really searched!"
      end
    end
  end
end
