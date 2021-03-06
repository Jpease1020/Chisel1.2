gem 'minitest', '~> 5.2'
require 'minitest/autorun'
require 'minitest/pride'
require '../lib/paragraph'

class ParagraphTest < Minitest::Test

  def test_it_is_a_paragraph
    chunk = "You just *have* to try the cheesecake,\" he said. \"Ever since it appeared in
    **Food & Wine** this place has been packed every night."
    para = Paragraph.new(chunk)
    assert para.is_a?(Paragraph)
  end

  def test_can_split_chunk
    chunk = "This is a **Food** magazine."
    para = Paragraph.new(chunk)
    result = para.chunks
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

  def test_it_adds_wrapper
    chunk = "You just *have to try* the cheesecake."
    para = Paragraph.new(chunk)
    result = para.add_wrapper
    assert_equal "\<p>\n" + "You just *have to try* the cheesecake.\n</p>\n\n", result
  end

  def test_can_convert_a_paragraph
    chunk = "You just *have* to try the cheesecake,\" he said. \"Ever since it appeared in **Food & Wine** this place has been packed every night."
    para = Paragraph.new(chunk)
    result = para.process
    assert_equal "<p>\n" + "You just <em>have</em> to try the cheesecake,\" he said. \"Ever since it appeared in <strong>Food &amp; Wine</strong> this place has been packed every night.\n</p>\n\n", result
  end


end
