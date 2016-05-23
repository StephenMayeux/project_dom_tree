require_relative 'parse.rb'

Node = Struct.new(:tag, :classes, :id, :name, :src, :title, :text, :children, :parent, :depth)

class DOMReader < Tree

  def build_tree
    @string = File.readlines('test.html').each { |line| @string += line.strip }
    super
  end

  def create_child(node)
    super(node)
  end

  def print_tree(node)
    super(node)
  end

end
