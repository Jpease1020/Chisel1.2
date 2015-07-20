gem 'minitest', '~> 5.2'
require 'minitest/autorun'
require 'minitest/pride'
require '../lib/chisel_1.2'

class ChiselTest < Minitest::Test

  def test_it_exists
    markdown = "Hi"
    html = Chisel.new(markdown)
    assert html, html
  end

  def test_it_works
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

html = Chisel.new(markdown).chisel
assert_equal "<h1>My Life in Desserts</h1>\n\n<h2>Chapter 1: The Beginning</h2>\n\n<p>\n\"You just <em>have</em> to try the cheesecake,\" he said. \"Ever since it appeared in <strong>Food &amp; Wine</strong> this place has been packed every night.\n</p>\n\n<p>\nMy favorite cuisines are:\n</p>\n\n<ul>\n<li>Sushi</li>\n<li>Barbeque</li>\n<li>Mexican</li>\n</ul>\n\n<p>\nMy favorite cuisines are:\n</p>\n\n<ol>\n<li>Sushi</li>\n<li>Barbeque</li>\n<li>Mexican</li>\n</ol>\n\n", html

  end

end
