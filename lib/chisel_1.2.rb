# read in the file contents from the markdown file (any file) and save it somewhere
# convert it to html
# print converted html into a new file called my_output.html (be able to make any file)
# print summary to the screen


# here is the commnad line command
# $ ruby ./lib/chisel.rb my_input.markdown my_output.html
# Converted my_input.markdown (6 lines) to my_output.html (8 lines)
require_relative 'paragraph'

class Chisel

attr_reader :markdown

  def initialize(markdown)
    @markdown = markdown
  end

  def splitter
    @markdown.split("\n\n")
  end

  def seperator
    splitter.map! do |chunk|


      if chunk.start_with?("#")
        chunk
      elsif chunk.start_with?("*")
        chunk
      elsif ["0","1","2","3","4","5","6","7","8","9"].include?(chunk[0])
        chunk
      else
        Paragraph.new(chunk).process
      end
    end
  end

end

# markdown = "# My Life
#
# You just *have* to
#
# * Sushi
#
# 1. Barbeque"
#
#  # =>
# chisel = Chisel.new(markdown)
# chisel.seperator  # => ["# My Life", "<p>\n\"You just <em>have</em> to\n</p>", "* Sushi", "1. Barbeque"]


# def seperator
#   splitter.map do |chunk|
#     if chunk.start_with("#")
#       Header.new(chunk)
#     elsif chunk.start_with("*")
#       UnorderedList.new(chunk)
#     elsif chunk.start_with(is_a?(Fixnum))
#       OrderedList.new(chunk)
#     else
#       Paragraph.new(chunk)
#     end
#   end
# end
