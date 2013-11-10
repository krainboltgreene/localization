require "spec_helper"

describe Localization do
  # def self.sources=(items)
  #   @@sources = items
  # end

  # def self.sources
  #   @@sources
  # end

  # def default_tree
  #   roots.inject({}) do |memo, subtree|
  #     memo.tap do |object|
  #       object.merge!(subtree)
  #     end
  #   end
  # end

  # def method_missing(name, *arguments, &block)
  #   case
  #     when @tree.respond_to?(:key?) && @tree.key?(name.to_s)
  #       Localization.new(@tree[name.to_s], @tree, arguments.first)
  #     when @parent.respond_to?(:key?) && @parent.key?(name.to_s)
  #       Localization.new(@parent[name.to_s], @parent, arguments.first)
  #     else "Localized text missing for #{name}"
  #   end
  # end

  describe "#method_missing" do
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
  end

  # def roots
  #   Localization.sources.map do |root|
  #     { key_from(root) => subtree_from(root) }
  #   end
  # end

  # def key_from(root)
  #   Pathname.new(root).basename(".yml").to_s
  # end

  # def subtree_from(path)
  #   YAML.load(File.read(path))
  # end
end
