require_relative 'parse.rb'
require_relative 'dom_reader.rb'
require_relative 'render.rb'
require_relative 'searcher.rb'

parse = Parse.new
x = parse.parse_tag("<p class='foo bar' id='baz' name='fozzie'>")
y = parse.parse_tag("<div id = 'bim'>")
z = parse.parse_tag("<img src='http://www.example.com' title='funny things'>")
puts x.type
puts x.classes
puts x.id
puts x.name

tree = Tree.new("<div>  div text before  <p>    p text  </p>  <div>    more div text  </div>  div text after</div>")
test = Tree.new(File.readlines('test.html').each { |line| @string += line.strip })
tree.print(tree.root)

reader = DOMReader.new(File.readlines('test.html').each { |line| @string += line.strip })
reader.print_tree(reader.root)

render = NodeRenderer.new(test)
render.render

searcher = TreeSearcher.new(test)
searcher.search_by(:class, "bold")
