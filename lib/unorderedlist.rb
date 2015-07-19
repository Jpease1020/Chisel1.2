
class UnorderedList

  attr_reader :chunk     # => nil
  def initialize(chunk)
    @chunk = chunk       # => "* Sushi\n* Barbeque\n* Mexican"
  end                    # => :initialize

  def process
    splitter
    list_maker
    add_wrapper
  end            # => :process

  def splitter
    chunk.split("\n")  # => ["* Sushi", "* Barbeque", "* Mexican"]
  end                  # => :splitter

  def list_maker
    splitter.map do |list|  # => ["* Sushi", "* Barbeque", "* Mexican"]
      list[0..1] = "<li>"   # => "<li>", "<li>", "<li>"
      list + "</li>\n"      # => "<li>Sushi</li>\n", "<li>Barbeque</li>\n", "<li>Mexican</li>\n"
    end                     # => ["<li>Sushi</li>\n", "<li>Barbeque</li>\n", "<li>Mexican</li>\n"]
  end                       # => :list_maker

  def add_wrapper
    "<ul>\n" + list_maker.join("") + "</ul>"
  end                                         # => :add_wrapper

end  # => :add_wrapper


# chunk = "* Sushi
# * Barbeque
# * Mexican"                        # => "* Sushi\n* Barbeque\n* Mexican"
# unord = UnorderedList.new(chunk)  # => #<UnorderedList:0x007faf5c867ed8 @chunk="* Sushi\n* Barbeque\n* Mexican">
# result = unord.list_maker         # => ["<li>Sushi</li>\n", "<li>Barbeque</li>\n", "<li>Mexican</li>\n"]

# My favorite cuisines are:
#
# * Sushi
# * Barbeque
# * Mexican
#
# <p>
#   My favorite cuisines are:
# </p>
#
# <ul>
#   <li>Sushi</li>
#   <li>Barbeque</li>
#   <li>Mexican</li>
# </ul
