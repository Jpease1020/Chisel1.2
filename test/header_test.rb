gem 'minitest', '~> 5.2'
require 'minitest/autorun'
require 'minitest/pride'
require '../lib/header'

class HeaderTest < Minitest::Test

  def test_it_exists
    chunk = "Hi"
    header = Header.new(chunk)
    assert header, header
  end

  def test_receives_string_input_and_returns_string
    assert_equal String, Header.new("# string").process.class
  end

  def test_it_creates_an_h1
    header = Header.new("# My Life in Desserts")
    assert_equal "<h1>My Life in Desserts</h1>\n\n", header.process
  end

  def test_it_creats_h2
    header = Header.new("## Chapter 1: The Beginning")
    assert_equal "<h2>Chapter 1: The Beginning</h2>\n\n", header.process
  end

  def test_it_creates_h_anything
    header = Header.new("##### Chapter 1: The Beginning")
    assert_equal "<h5>Chapter 1: The Beginning</h5>\n\n", header.process
  end

end
