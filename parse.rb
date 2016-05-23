Tag = Struct.new(:tag, :classes, :id, :name, :src)
Node = Struct.new(:tag, :classes, :id, :name, :src, :title, :text, :children, :parent, :depth)

class Parse

  def parse_tage(html)
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
    @parser = Parse.new
  end

end
