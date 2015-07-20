
class Paragraph

  attr_reader :chunks

  def initialize(chunks)
    @chunks = chunks.split(" ")
    @cleaned = ""
  end

  def process
    convert_to_strong
    convert_to_ems
    convert_ampersand
    add_wrapper
  end

  def convert_to_strong
      chunks.map! do |word|
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
    chunks.map! do |word|
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
    chunks.map! do |word|
      word.gsub("&", "&amp;")
    end.join(" ")
  end

  def add_wrapper
    "\<p>\n\"" + chunks.join(" ") + "\n</p>\n\n"
  end

end
