gem 'minitest', '~> 5.2'
require 'minitest/autorun'
require 'minitest/pride'
require '../lib/parser' # ~> LoadError: cannot load such file -- ../lib/parser_1.2

class ParserTest < Minitest::Test

  def test_it_exists
    markdown = "Hi"
    parser = Parser.new(markdown)
    assert parser, parser
  end

  def test_it_splits_a_string_on_new_lines
    markdown = "# My Life

You just *have* to

* Sushi

1. Barbeque"
    parser = Parser.new(markdown)
    result = parser.splitter
    assert_equal ["# My Life", "You just *have* to", "* Sushi", "1. Barbeque"], result
  end

  def test_it_separates_chunks_into_correct_parts_and_converts_chunks_with_small_markdown
    markdown = "# My Life

You just *have* to

* Sushi

1. Barbeque"
    parser = Parser.new(markdown)
    result = parser.converter
    assert_equal "<h1>My Life</h1>

<p>
You just <em>have</em> to
</p>

<ul>
<li>Sushi</li>
</ul>

<ol>
<li>Barbeque</li>
</ol>

", result
  end

  def test_it_converts_chunks_with_full_markdown
    markdown = "# My Life in Desserts

## Chapter 1: The Beginning

\"You just *have* to try the cheesecake,\" he said. \"Ever since it appeared in **Food & Wine** this place has been packed every night.

My favorite cuisines are:

* Sushi
* Barbeque
* Mexican

My favorite cuisines are:

1. Sushi
2. Barbeque
3. Mexican"

    parser = Parser.new(markdown)
    result = parser.converter
    assert_equal "<h1>My Life in Desserts</h1>\n\n<h2>Chapter 1: The Beginning</h2>\n\n<p>\n\"You just <em>have</em> to try the cheesecake,\" he said. \"Ever since it appeared in <strong>Food &amp; Wine</strong> this place has been packed every night.\n</p>\n\n<p>\nMy favorite cuisines are:\n</p>\n\n<ul>\n<li>Sushi</li>\n<li>Barbeque</li>\n<li>Mexican</li>\n</ul>\n\n<p>\nMy favorite cuisines are:\n</p>\n\n<ol>\n<li>Sushi</li>\n<li>Barbeque</li>\n<li>Mexican</li>\n</ol>\n\n", result

  end

end
