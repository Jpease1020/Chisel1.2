require_relative 'paragraph'
require_relative 'unorderedlist'

class Chisel

attr_reader :markdown

  def initialize(markdown)
    @markdown = markdown
  end

  def splitter
    @markdown.split("\n\n")
  end

  def chiseler
    splitter.map! do |chunk|
      if chunk.start_with?("#")
        chunk
      elsif chunk.start_with?("*")
        UnorderedList.new(chunk).process
      elsif ["0","1","2","3","4","5","6","7","8","9"].include?(chunk[0])
        chunk
      else
        Paragraph.new(chunk).process
      end
    end
  end

end
