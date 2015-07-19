
class Paragraph

  attr_reader :chunk

  def initialize(chunk)
    @chunk = chunk.split(" ")
    @cleaned = ""
  end

  def process
    convert_to_strong
    convert_to_ems
    convert_ampersand
    add_wrapper
  end

  def convert_to_strong
      chunk.map! do |word|
      if word.end_with?("**")
          word[-2..-1] = "</strong>"
          word
      end
      if word.start_with?("**")
        word[0..1] = "<strong>"
        word
      else
        word
      end
    end.join(" ")
  end

  def convert_to_ems
    chunk.map! do |word|
      if word.start_with?("*")
        replace_beginning_em(word)
      end
      if word.end_with?("*")
        replace_ending_em(word)
      else
        word
      end
    end.join(" ")
  end

  def replace_beginning_em(word)
    word[0] = "<em>"
    word
  end

  def replace_ending_em(word)
    word[-1] = "</em>"
    word
  end

  def convert_ampersand
    chunk.map! do |word|
      word.gsub("&", "&amp;")
    end.join(" ")
  end

  def add_wrapper
    "\<p>\n\"" + chunk.join(" ") + "\n</p>"
  end

end

#
# string = "You just *have* to try the cheesecake,\" he said. \"Ever since it appeared in
# # # **Food & Wine** this place has been packed every night."
# para = Paragraph.new(string)
# # => NoMethodError: undefined method `convert_to_ems' for #<String:0x007ffb038281f0>
#
# a = para.convert_ampersand # => "You just *have* to try the cheesecake,\" he said. \"Ever since it appeared in **Food &amp; Wine** this place has been packed every night."
# a.convert_to_ems # => NoMethodError: undefined method `convert_to_ems' for #<String:0x007faf6c87c300>
#
# # ~> NoMethodError

# ~> NoMethodError
# ~> undefined method `convert_to_ems' for #<String:0x007ffb038281f0>
# ~>
# ~> /Users/justinpease/Turing_All/Module_1.2/Projects/chisel1.2/lib/paragraph.rb:74:in `<main>'
