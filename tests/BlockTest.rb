require 'tk'
require_relative '../lib/Block'
require 'minitest/autorun'

class BlockTester < MiniTest::Unit::TestCase
  puts("---------Block Test---------")

  ROOT_WINDOW = TkRoot.new(:title => "Memory Blocks", :width => '600', :height => '600')

  def test_initialize
    puts("Block#initialize")
    block = Block.new(ROOT_WINDOW, 2, 'img2.gif', 4)
    assert_equal(2, block.id)
    assert(block.button)
  end

  def test_open
    puts("Block#open")
    block = Block.new(ROOT_WINDOW, 2, 'img3.gif', 4)
    block.open
    assert_equal('resources/images4/img3.gif', block.button.image.cget(:file))
  end

  def test_close
    puts("Block#close")
    block = Block.new(ROOT_WINDOW, 2, 'img2.gif', 6)
    block.close
    assert_equal('background.gif', block.button.image.cget(:file))
  end

  def test_get_picture_name
    puts("Block#get_picture_name")
    block = Block.new(ROOT_WINDOW, 2, 'img2.gif', 6)
    assert_equal('resources/images6/img2.gif', block.get_picture_name)
  end
end
