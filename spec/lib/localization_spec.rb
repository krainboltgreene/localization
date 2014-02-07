require "spec_helper"

describe Localization do
  let(:english) do
    {
      "en" => {
        "name" => "Funworld",
        "pages" => {
          "splash" => {
            "title" => "Welcome to {{world}}!"
          },
          "header" => "I love lucy."
        },
        "accounts" => {
          "edit" => {
            "form_header" => "Edit Your Account"
          }
        }
      }
    }
  end
  let(:localization) { described_class.new(english) }

  describe "#method_missing" do
    let(:content) { localization.en.pages.splash }

    it "returns rendered content" do
      expect(content.title(world: "Foo").to_s).to eq("Welcome to Foo!")
    end

    it "returns content one level up if it can find it" do
      expect(content.header.to_s).to eq("I love lucy.")
    end

    it "returns content any level up if it can find it" do
      expect(content.name.to_s).to eq("Funworld")
    end

    it "returns unfindable message if it can never find it" do
      expect(content.woop.to_s).to eq("Localized text missing for woop")
    end

    it "returns unfindable message even if we call other stuff on it" do
      expect(content.woop.foop.to_s).to eq("Localized text missing for woop")
    end
  end
end
