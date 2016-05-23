require_relative 'parse.rb'

Node = Struct.new(:tag, :classes, :id, :name, :src, :title, :text, :children, :parent, :depth)

class DOMReader < Tree

  def initialize(html)
    super(html)
  end

  def build_tree
    super
  end

  def create_child(node)
    super(node)
  end

  def print_tree(node)
    super(node)
  end

end
