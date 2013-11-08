require "spec_helper"

describe Localization::VERSION do
  it "should be a string" do
    expect(Localization::VERSION).to be_kind_of(String)
  end
end
