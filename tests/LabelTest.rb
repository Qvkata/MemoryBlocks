require 'tk'
require_relative '../lib/Frame'
require 'minitest/autorun'

class LabelTest < MiniTest::Unit::TestCase
  puts("---------Label Test---------")

  ROOT_WINDOW = TkRoot.new(:title => "Memory Blocks", :width => '600', :height => '600')

  def test_initialize
    puts("Label#initialize")
    my_label = Label.new(ROOT_WINDOW, 0)
    assert_equal('SCORE: 0', my_label.label.text)
  end

  def test_set_score
    puts("Label#set_score")
    my_label = Label.new(ROOT_WINDOW, 0)
    my_label.set_score(10)
    assert_equal('SCORE: 10', my_label.label.text)
  end
end