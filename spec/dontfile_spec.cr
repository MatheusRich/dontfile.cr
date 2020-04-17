require "./spec_helper"

describe Dontfile do
  it "has a version" do
    Dontfile::VERSION.should_not be_nil
  end
end
