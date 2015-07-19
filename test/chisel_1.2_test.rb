gem 'minitest', '~> 5.2'
require 'minitest/autorun'
require 'minitest/pride'
require '../lib/chisel_1.2' # ~> LoadError: cannot load such file -- ../lib/chisel_1.2

class ChiselTest < Minitest::Test

  def test_it_exists
    markdown = "Hi"
    chisel = Chisel.new(markdown)
    assert chisel, chisel
  end

  def test_it_splits_a_string_on_new_lines
    markdown = "# My Life

You just *have* to

* Sushi

1. Barbeque"
    chisel = Chisel.new(markdown)
    result = chisel.splitter
    assert_equal ["# My Life", "You just *have* to", "* Sushi", "1. Barbeque"], result
  end

  def test_it_separates_chunks_into_correct_parts
    markdown = "# My Life

You just *have* to

* Sushi

1. Barbeque"
    chisel = Chisel.new(markdown)
    result = chisel.seperator
    # assert result[0].is_a?(Header)
    assert "<p>\n\"You just <em>have</em> to\n</p>", result[1]
    # assert result[2].is_a?(UnorderedList)
    # assert result[3].is_a?(OrderedList)
  end
end



# ~> LoadError
# ~> cannot load such file -- ../lib/chisel_1.2
# ~>
# ~> /Users/justinpease/.rvm/rubies/ruby-2.2.1/lib/ruby/site_ruby/2.2.0/rubygems/core_ext/kernel_require.rb:54:in `require'
# ~> /Users/justinpease/.rvm/rubies/ruby-2.2.1/lib/ruby/site_ruby/2.2.0/rubygems/core_ext/kernel_require.rb:54:in `require'
# ~> /Users/justinpease/Turing_All/Module_1.2/Projects/chisel1.2/test/chisel_1.2_test.rb:4:in `<main>'
