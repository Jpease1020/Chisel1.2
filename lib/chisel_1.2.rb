require_relative 'parser'

class Chisel

  attr_reader :markdown_text
  def initialize(markdown_text)
    @markdown_text = markdown_text
  end

  def chisel
    Parser.new(@markdown_text).converter
  end

end

markdown_text = File.read(ARGV[0])
html_text = Chisel.new(markdown_text).chisel
File.write(ARGV[1], html_text)
