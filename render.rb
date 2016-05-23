require_relative 'dom_reader.rb'

class NodeRenderer

  def initialize(tree)
    @tree, @queue = tree, []
  end

  def render(node=@tree)
    puts "This sub tree has:"
    puts "#{counter(node)[2]} total nodes"
    puts "#{counter(node)[1]} total tags"
    puts "#{counter(node)[0]} total chunks of text\n\n"

    puts "For this particular node: "
    puts "tag: #{node.tag}" if node.tag
    puts "classes: #{node.classes}" if node.classes.size > 0
    puts "id: #{node.id}" if node.id
    puts "name: #{node.name}" if node.name
    puts "src: #{node.src}" if node.src
    puts "text: #{node.text}" if node.text
  end

  def counter(node)
    text_counter, tag_counter, node_counter = 0, 0, 0
    @queue << node
    loop do
      current_node = @queue.shift
      node_counter += current_node.children.length
      current_node.children.each do |child|
        text_counter += 1 if child.text
        tag_counter += 1 if child.tag
        @queue << child
      end
      break if @queue.empty?
    end
    [text_counter, tag_counter, node_counter]
  end

end
