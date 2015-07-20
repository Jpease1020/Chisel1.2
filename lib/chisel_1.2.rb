require_relative 'paragraph'      # => true
require_relative 'unorderedlist'  # => true
require_relative 'ordered_list'   # => true
require_relative 'header'         # => true

class Chisel

attr_reader :markdown  # => nil

  def initialize(markdown)
    @markdown = markdown    # => "# My Life\n\nYou just *have* to\n\n* Sushi\n\n1. Barbeque"
  end                       # => :initialize

  def splitter
    @markdown.split("\n\n")  # => ["# My Life", "You just *have* to", "* Sushi", "1. Barbeque"]
  end                        # => :splitter

  def chiseler
    splitter.map! do |chunks|                                              # => ["# My Life", "You just *have* to", "* Sushi", "1. Barbeque"]
      if chunks.start_with?("#")                                           # => true, false, false, false
        Header.new(chunks).process                                         # => "<h1>My Life</h1>\n\n"
      elsif chunks.start_with?("*")                                        # => false, true, false
        UnorderedList.new(chunks).process                                  # => "<ul>\n<li>Sushi</li>\n</ul>\n\n"
      elsif ["0","1","2","3","4","5","6","7","8","9"].include?(chunks[0])  # => false, true
        OrderedList.new(chunks).process                                    # => "<ol>\n<li>Barbeque</li>\n</ol>\n\n"
      else
        Paragraph.new(chunks).process                                      # => "<p>\n\"You just <em>have</em> to\n</p>\n\n"
      end                                                                  # => "<h1>My Life</h1>\n\n", "<p>\n\"You just <em>have</em> to\n</p>\n\n", "<ul>\n<li>Sushi</li>\n</ul>\n\n", "<ol>\n<li>Barbeque</li>\n</ol>\n\n"
    end.join(" ")                                                          # => "<h1>My Life</h1>\n\n <p>\n\"You just <em>have</em> to\n</p>\n\n <ul>\n<li>Sushi</li>\n</ul>\n\n <ol>\n<li>Barbeque</li>\n</ol>\n\n"
  end                                                                      # => :chiseler

end  # => :chiseler

markdown = "# My Life

You just *have* to

* Sushi

1. Barbeque"                   # => "# My Life\n\nYou just *have* to\n\n* Sushi\n\n1. Barbeque"
chisel = Chisel.new(markdown)  # => #<Chisel:0x007f8845072040 @markdown="# My Life\n\nYou just *have* to\n\n* Sushi\n\n1. Barbeque">
puts result = chisel.chiseler  # => nil

# >> <h1>My Life</h1>
# >>
# >>  <p>
# >> "You just <em>have</em> to
# >> </p>
# >>
# >>  <ul>
# >> <li>Sushi</li>
# >> </ul>
# >>
# >>  <ol>
# >> <li>Barbeque</li>
# >> </ol>
# >>
