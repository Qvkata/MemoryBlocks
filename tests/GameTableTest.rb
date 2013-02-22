require 'tk'
require_relative '../lib/GameTable'
require 'minitest/autorun'

class GameTableTest < MiniTest::Unit::TestCase
  puts("-------GameTable Test-------")

  ROOT_WINDOW = TkRoot.new(:title => "Memory Blocks", :width => '600', :height => '600')

  def test_initialize
    puts("GameTable#initialize")
    table = GameTable.new(ROOT_WINDOW, 4)
    assert_equal(4, table.size)
    assert_equal(0, table.score)
    assert_equal([0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15], table.blocks.map { |block| block.id })
  end

  def test_block_function
    puts("GameTable#block_function")
    table = GameTable.new(ROOT_WINDOW, 6)
    table.block_function(1)
    assert(table.blocks[1].button.image.cget(:file) != 'background.gif', 'Failure when opening the button')
    assert_equal(1, table.open_block1)
    table.block_function(5)
    assert(table.blocks[5].button.image.cget(:file) != 'background.gif', 'Failure when opening the button')
    assert_equal(5, table.open_block2)
  end

  def test_compare_blocks1
    puts("GameTable#compare_blocks 1")
    table = GameTable.new(ROOT_WINDOW, 4)
    table.open_block1 = 1
    table.open_block2 = 7
    table.blocks[1].set_picture('img2.gif', 4)
    table.blocks[7].set_picture('img2.gif', 4)
    table.compare_blocks
    sleep 1.3
    assert_equal([1, 7], table.removed_blocks)
    assert_equal(1, table.score)
  end

  def test_compare_blocks2
    puts("GameTable#compare_blocks 2")
    table = GameTable.new(ROOT_WINDOW, 6)
    table.open_block1 = 5
    table.open_block2 = 30
    table.blocks[5].set_picture('img3.gif', 6)
    table.blocks[30].set_picture('img2.gif', 6)
    table.compare_blocks
    sleep 1.1
    assert_equal([], table.removed_blocks)
    assert_equal(0, table.score)
    assert_equal(table.blocks[5].button.image.cget(:file), 'background.gif')
    assert_equal(table.blocks[30].button.image.cget(:file), 'background.gif')
  end

  def test_clear_table
    puts("GameTable#clear_table")
    table = GameTable.new(ROOT_WINDOW, 6)
    table.clear_table
    assert_equal([], table.blocks)
    assert_equal([], table.removed_blocks)
  end

  def test_save_load_table
    puts("GameTable#save/load_table")
    table = GameTable.new(ROOT_WINDOW, 4)
    table.open_block1 = 1
    table.open_block2 = 7
    table.blocks[1].set_picture('img2.gif', 4)
    table.blocks[7].set_picture('img2.gif', 4)
    table.compare_blocks
    sleep 1.3
    table.save_table('tests/saved_game_test')
    table.load_table('tests/saved_game_test')
    assert_equal([0, nil, 2, 3, 4, 5, 6, nil, 8, 9, 10, 11, 12, 13, 14, 15],
                 table.blocks.map { |block| block.id if block != nil})
    assert_equal([1, 7], table.removed_blocks)
    assert_equal(1, table.score)
    assert_equal(4, table.size)
  end
end
