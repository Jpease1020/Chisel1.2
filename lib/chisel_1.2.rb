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
      if chunks.start_with?("#")                                           # => true
        Header.new(chunks).process                                         # ~> NoMethodError: undefined method `process' for #<Header:0x007ff6190a9f58 @chunks="# My Life">
      elsif chunks.start_with?("*")
        UnorderedList.new(chunks).process
      elsif ["0","1","2","3","4","5","6","7","8","9"].include?(chunks[0])
        OrderedList.new(chunks).process
      else
        Paragraph.new(chunks).process
      end
    end
  end                                                                      # => :chiseler

end  # => :chiseler

markdown = "# My Life

You just *have* to

* Sushi

1. Barbeque"  # => "# My Life\n\nYou just *have* to\n\n* Sushi\n\n1. Barbeque"

chisel = Chisel.new(markdown)  # => #<Chisel:0x007ff6190ab358 @markdown="# My Life\n\nYou just *have* to\n\n* Sushi\n\n1. Barbeque">
chisel.chiseler

# ~> NoMethodError
# ~> undefined method `process' for #<Header:0x007ff6190a9f58 @chunks="# My Life">
# ~>
# ~> /Users/justinpease/Turing_All/Module_1.2/Projects/chisel1.2/lib/chisel_1.2.rb:21:in `block in chiseler'
# ~> /Users/justinpease/Turing_All/Module_1.2/Projects/chisel1.2/lib/chisel_1.2.rb:19:in `map!'
# ~> /Users/justinpease/Turing_All/Module_1.2/Projects/chisel1.2/lib/chisel_1.2.rb:19:in `chiseler'
# ~> /Users/justinpease/Turing_All/Module_1.2/Projects/chisel1.2/lib/chisel_1.2.rb:43:in `<main>'
