require "yaml"
require "mustache"

class Localization
  @@sources = []

  def self.sources=(items)
    @@sources = items
  end

  def self.sources
    @@sources
  end

  def initialize(tree = nil, assignments = nil)
    @assignments = assignments || {}
    @tree = tree || roots.inject({}) do |memo, subtree|
      memo.tap do |object|
        object.merge!(subtree)
      end
    end
  end

  def method_missing(name, *arguments, &block)
    if @tree.respond_to?(:key?) && @tree.key?(name.to_s)
      Localization.new(@tree[name.to_s], arguments.first)
    else
      super
    end
  end

  def to_s
    Mustache.render(@tree, @assignments)
  end

  private

  def roots
    Localization.sources.map do |root|
      { key_from(root) => subtree_from(root) }
    end
  end

  def key_from(root)
    Pathname.new(root).basename(".yml").to_s
  end

  def subtree_from(path)
    YAML.load(File.read(path))
  end
end

require_relative "localization/version"
