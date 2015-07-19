gem 'minitest', '~> 5.2'    # => true
require 'minitest/autorun'  # => true
require 'minitest/pride'    # => true
require '../lib/paragraph'  # ~> LoadError: cannot load such file -- ../lib/paragraph
class ParagraphTest < Minitest::Test

  def test_it_is_a_paragraph
    skip
    chunk = "You just *have* to try the cheesecake,\" he said. \"Ever since it appeared in
    **Food & Wine** this place has been packed every night."
    para = Paragraph.new(chunk)
    refute para.is_a?(Header)
    refute para.is_a?(OrderedList)
    refute para.is_a?(List)
  end

  def test_can_split_chunk
    chunk = "This is a **Food** magazine."
    para = Paragraph.new(chunk)
    result = para.chunk
    assert result.is_a?(Array)
  end

  def test_can_change_doule_stars_to_strongs
    chunk = "This is a **Food** magazine."
    para = Paragraph.new(chunk)
    result = para.convert_to_strong
    assert_equal "This is a <strong>Food</strong> magazine.", result
  end

  def test_change_multiple_words_in_doule_stars_to_strongs
    chunk = "This is a **Food and Wine** magazine."
    para = Paragraph.new(chunk)
    result = para.convert_to_strong
    assert_equal "This is a <strong>Food and Wine</strong> magazine.", result
  end

  def test_can_change_single_stars_to_em
    chunk = "You just *have* to try the cheesecake."
    para = Paragraph.new(chunk)
    result = para.convert_to_ems
    assert_equal "You just <em>have</em> to try the cheesecake.", result
  end

  def test_can_change_multiple_words_in_single_stars_to_em
    chunk = "You just *have to try* the cheesecake."
    para = Paragraph.new(chunk)
    result = para.convert_to_ems
    assert_equal "You just <em>have to try</em> the cheesecake.", result
  end

  def test_can_convert_ampersand_to_markdown_version
    chunk = "This & that."
    para = Paragraph.new(chunk)
    result = para.convert_ampersand
    assert_equal "This &amp; that.", result
  end

  def test_it_adds_the_beginning_and_end_p_thingies
    chunk = "You just *have to try* the cheesecake."
    para = Paragraph.new(chunk)
    result = para.add_wrapper
    assert_equal "\<p>\n\"You just *have to try* the cheesecake.\n</p>", result
  end

  def test_can_convert_a_paragraph
    chunk = "You just *have* to try the cheesecake,\" he said. \"Ever since it appeared in **Food & Wine** this place has been packed every night."
    para = Paragraph.new(chunk)
    result = para.process
    assert_equal "<p>\n\"You just <em>have</em> to try the cheesecake,\" he said. \"Ever since it appeared in <strong>Food &amp; Wine</strong> this place has been packed every night.\n</p>", result
  end


end
