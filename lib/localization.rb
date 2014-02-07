require "yaml"
require "mustache"

# This is the main namespace for your gem
class Localization < BasicObject
  @@sources = []

  def self.sources=(items)
    @@sources = items
  end

  def self.sources
    @@sources
  end

  def initialize(tree = nil, assignments = nil, parent = nil, error = nil)
    unless error
      @assignments = assignments || ::Hash.new
      @parent = parent
      @tree = tree || default_tree
    else
      @error = error
    end
  end

  def method_missing(name, *arguments, &block)
    case
      when @tree.respond_to?(:key?) && @tree.key?(name.to_s)
        ::Localization.new(@tree[name.to_s], arguments.first, self)
      when !@parent.nil?
        @parent.send(name, arguments.first)
      else ::Localization.new(nil, nil, nil, @error || "Localized text missing for #{name}")
    end
  end

  def to_s
    @error || ::Mustache.render(@tree, @assignments)
  end

  private

  def default_tree
    roots.inject(::Hash.new) do |memo, subtree|
      memo.tap do |object|
        object.merge!(subtree)
      end
    end
  end

  def roots
    ::Localization.sources.map do |root|
      { key_from(root) => subtree_from(root) }
    end
  end

  def key_from(root)
    ::Pathname.new(root).basename(".yml").to_s
  end

  def subtree_from(path)
    ::YAML.load(::File.read(path))
  end

  require_relative "localization/version"
end
