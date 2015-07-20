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
    assert "<p>\n\"You just <em>have</em> to\n</p>", result[1]
  end

  def test_it_converts_chunks_with_full_markdown
    skip
    markdown = "# My Life in Desserts

## Chapter 1: The Beginning"

"You just *have* to try the cheesecake,\" he said. \"Ever since it appeared in
**Food & Wine** this place has been packed every night.

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
    assert "<h1>My Life in Desserts</h1>

<h2>Chapter 1: The Beginning</h2>

<p>
  \"You just <em>have</em> to try the cheesecake,\" he said. \"Ever since it appeared in
  <strong>Food &amp; Wine</strong> this place has been packed every night.\"
</p>

<p>
  My favorite cuisines are:
</p>

<ul>
  <li>Sushi</li>
  <li>Barbeque</li>
  <li>Mexican</li>
</ul>

<p>
  My favorite cuisines are:
</p>

<ol>
  <li>Sushi</li>
  <li>Barbeque</li>
  <li>Mexican</li>
</ol>", result

  end

end
