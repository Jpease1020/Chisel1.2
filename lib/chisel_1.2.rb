require_relative 'parser'  # => true

class Chisel

  attr_reader :markdown_text        # => nil
  def initialize(markdown_text)
    @markdown_text = markdown_text  # => "# My Life in Desserts\n\n## Chapter 1: The Beginning\n\n\"You just *have* to try the cheesecake,\" he said. \"Ever since it appeared in **Food & Wine** this place has been packed every night.\n\nMy favorite cuisines are:\n\n* Sushi\n* Barbeque\n* Mexican\n\nMy favorite cuisines are:\n\n1. Sushi\n2. Barbeque\n3. Mexican"
  end                               # => :initialize

  def chisel
    Parser.new(@markdown_text).converter  # => "<h1>My Life in Desserts</h1>\n\n<h2>Chapter 1: The Beginning</h2>\n\n<p>\n\"You just <em>have</em> to try the cheesecake,\" he said. \"Ever since it appeared in <strong>Food &amp; Wine</strong> this place has been packed every night.\n</p>\n\n<p>\nMy favorite cuisines are:\n</p>\n\n<ul>\n<li>Sushi</li>\n<li>Barbeque</li>\n<li>Mexican</li>\n</ul>\n\n<p>\nMy favorite cuisines are:\n</p>\n\n<ol>\n<li>Sushi</li>\n<li>Barbeque</li>\n<li>Mexican</li>\n</ol>\n\n"
  end                                     # => :chisel

end  # => :chisel

markdown_text = File.read(ARGV[0])
html_text = Chisel.new(markdown_text).chisel
File.write(ARGV[1], html_text)
