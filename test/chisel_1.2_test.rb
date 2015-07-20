gem 'minitest', '~> 5.2'
require 'minitest/autorun'
require 'minitest/pride'
require '../lib/chisel_1.2' # ~> LoadError: cannot load such file -- ../lib/chisel_1.2

class ChiselTest < Minitest::Test

  def test_it_exists
    markdown = "Hi"
    html = Chisel.new(markdown)
    assert html, html
  end

end
