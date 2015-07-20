require_relative 'paragraph'
require_relative 'unorderedlist'
require_relative 'ordered_list'
require_relative 'header'

class Parser

  attr_reader :markdown

  def initialize(markdown)
    @markdown = markdown
  end

  def splitter
    @markdown.split("\n\n")
  end

  def converter
    splitter.map! do |chunks|
      if chunks.start_with?("#")
        Header.new(chunks).process
      elsif chunks.start_with?("*")
        UnorderedList.new(chunks).process
      elsif ["0","1","2","3","4","5","6","7","8","9"].include?(chunks[0])
        OrderedList.new(chunks).process
      else
        Paragraph.new(chunks).process
      end
    end.join
  end

end  
