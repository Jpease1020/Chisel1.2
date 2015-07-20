class Header

  attr_reader :chunks
  def initialize(chunks)
    @chunks = chunks
  end

  def process
    space_index = chunks.index(" ")
    without_markdown = chunks[space_index + 1..-1]
    "<h#{space_index}>#{without_markdown}</h#{space_index}>\n\n"
  end

end
