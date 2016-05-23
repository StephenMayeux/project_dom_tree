require_relative 'dom_reader.rb'
require_relative 'render.rb'

class TreeSearcher

  def initialize(tree)
    @tree, @queue = tree, []
  end

  def search_by(attribute, value)
    nodes = []
    @queue << @tree
    loop do
      current_node = @queue.shift
      nodes << current_node if attribute == :id && current_node.id == value
      nodes << current_node if attribute == :classes && current_node.classes.include?(value)
      nodes << current_node if attribute == :tag && current_node.tag == value
      current_node.children.each do |child|
        @queue << child
      end
      break if @queue.empty?
    end
    nodes
  end

  def search_children(node, attribute, value)
    nodes = []
    node.children.each do |n|
      @queue << n
    end
    loop do
      current_node = @queue.shift
      nodes << current_node if attribute == :id && current_node.id == value
      nodes << current_node if attribute == :classes && current_node.classes.include?(value)
      nodes << current_node if attribute == :tag && current_node.tag == value
      current_node.children.each do |child|
        @queue << child
      end
      break if @queue.empty?
    end
    nodes
  end

  def search_ancestors(node, attribute, value)
    nodes = []
    @queue << node.parent
    loop do
      current_node = @queue.shift
      nodes << current_node if attribute == :id && current_node.id == value
      nodes << current_node if attribute == :classes && current_node.classes.include?(value)
      nodes << current_node if attribute == :tag && current_node.tag == value
      @queue << current_node.parent if current_node.parent != nil
      break if @queue.empty?
    end
    nodes
  end

end
