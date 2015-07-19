
class UnorderedList

  attr_reader :chunk
  def initialize(chunk)
    @chunk = chunk
  end

  def process
    splitter
    list_maker
    add_wrapper
  end

  def splitter
    chunk.split("\n")
  end

  def list_maker
    splitter.map do |list|
      list[0..1] = "<li>"
      list + "</li>\n"
    end
  end

  def add_wrapper
    "<ul>\n" + list_maker.join("") + "</ul>"
  end

end
