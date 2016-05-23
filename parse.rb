Tag = Struct.new(:tag, :classes, :id, :name, :src)
Node = Struct.new(:tag, :classes, :id, :name, :src, :title, :text, :children, :parent, :depth)

class Parse

  def parse_tag(html)
    tag = Tag.new(nil, [], nil, nil, nil)
    if html[0] == "<"
      tag.tag = /<(\w+)/.match(string)[1]
      tag.classes = /class[\s=]+['"](.*?)['"]/.match(string)[1].split(" ") if string.include? "class"
      tag.id = /id[\s=]+['"](.*?)['"]/.match(string)[1] if string.include? "id"
      tag.name = /name[\s=]+'(\w+)/.match(string)[1] if string.include? "name"
      tag.src = /src[\s=]+'([\w:\.\/]+)/.match(string)[1] if string.include? "src"
    end
    return tag
  end

end

class Tree

  attr_accessor :parser, :root, :string

  def initialize(string)
    @parser, @string = Parse.new, string
    @root = Node.new(nil, [], nil, nil, nil, nil, nil, [], nil, 0)
    create_child(@root)
    @string = />(.*)/.match(@string)[1].strip
    @stack = [@root]
    build_tree
  end

  def build_tree
    loop do
      current_node = @stack.pop
      loop do
        if @string[0] != "<"
          child_node = Node.new(nil, [], nil, nil, nil, nil, nil, [], current_node, current_node.depth+1)
          create_child(child_node)
          current_node.children << child_node
          @string = /(<.*)/.match(@string)[1].strip
        elsif @string[0..1] == "</"
          @string = />(.*)/.match(@string)[1].strip
          break
        elsif @string[0..1] == "<"
          child_node = Node.new(nil, [], nil, nil, nil, nil, nil, [], current_node, current_node.depth+1)
          create_child(child_node)
          current_node.children << child_node
          @stack << child_node
          @string = />(.*)/.match(@string)[1].strip
          build_tree
        end
      end
      break if @stack.empty?
    end
  end

  def create_child(node)
    if @string[0] == "<"
      to_be_parsed = /(<\w+>)/.match(@string)[0]

      node.tag = @parser.parse_tag(to_be_parsed).tag
      node.classes = @parser.parse_tag(to_be_parsed).classes
      node.id = @parser.parse_tag(to_be_parsed).id
      node.name = @parser.parse_tag(to_be_parsed).name
      node.src = @parser.parse_tag(to_be_parsed).src
    else
      node.text = /(.*?)</.match(@string)[1].strip
    end
  end

  def print_tree(node)
    @stack << node
    loop do
      current_node = @stack.pop
      if current_node.tag
        string = ""
        current_node.depth.times { string += " " }
        string += "<#{current_node.tag}"
        if current_node.classes.length > 0
          string += " class='"
          current_node.classes.each { |class| string += class }
          string.strip += "'"
        end
        string += " id='#{current_node.id}'" if current_node.id
        string += " name='#{current_node.name}'" if current_node.name
        string += " src='#{current_node.src}'" if current_node.src
        string += " title='#{current_node.title}'" if current_node.title
        puts string += ">"
        current_node.children.each { |child| print_tree(child) } if current_node.children.size > 0
        current_node.depth.times { print " " }
        puts "</#{current_node.tag}"
      else
        string = ""
        current_node.depth.times { string += " " }
        string += "#{current_node.text}"
        puts string
      end
      break if @stack.empty
    end
  end

end
