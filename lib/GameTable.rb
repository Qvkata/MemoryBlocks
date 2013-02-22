require_relative 'Block'
require_relative 'Label'
require_relative 'Message'

class GameTable
  attr_reader :size, :score, :blocks, :removed_blocks
  attr_accessor :open_block1, :open_block2

  def initialize(root, size)
    @size = size
    @score = 0
    @click_counter = 0
    @root = root
    @blocks = []
    @removed_blocks = []
    @label = Label.new(root, @score)
    set_blocks((0..(size * size -1)).to_a, set_images)
  end

  def save_table(file_name)
    return if @blocks.empty?
    saved_blocks = (0..(@size * @size - 1)).to_a - @removed_blocks
    file = File.new file_name, 'w'
    file.write(@removed_blocks)
    file.write("\n")
    file.write([saved_blocks.size, @score, @size])
    file.write("\n")
    saved_blocks.each do |id|
      file.write([id, @blocks[id].get_picture_name])
      file.write("\n")
    end
    file.close
  end

  def load_table(file_name)
    clear_table
    images = []
    blocks = []
    file = File.new file_name, 'r'
    @removed_blocks = file.gets.delete('[').chop.split(',').map{ |digit| digit.to_i}
    numbers_of_blocks, @score, @size = file.gets.delete('[').chop.split(',').map { |digit| digit.to_i }
    numbers_of_blocks.times do |current|
      line = file.gets.delete('[').delete(']').chop.split(',')
      blocks[current] = line.first.to_i
      images[current] = line.last.delete("\"").delete(" ").match(/\/img.*/).to_s
    end
    set_blocks(blocks, images)
    @label.set_score(@score)
  end

  def clear_table
    @blocks.each { |block| block.destroy if block != nil }
    @blocks.clear
    @removed_blocks.clear
  end

  #private

  def set_images
    (1.upto((@size * @size) / 2).map { |img_number| 'img' + img_number.to_s + '.gif' } * 2).shuffle
  end

  def set_blocks(blocks_id, images)
    blocks_id.each do |id|
      @blocks[id] = Block.new(@root, id, images.shift, @size)
      @blocks[id].button.command = proc {block_function(id)}
    end
  end

  def block_function(id)
    @click_counter = @click_counter + 1
    if @click_counter == 1
      @blocks[id].open
      @open_block1 = id
    elsif @click_counter == 2 and  @open_block1 == id
      @click_counter = 1
    elsif @click_counter == 2
      @blocks[id].open
      @open_block2 = id
      compare_blocks
    end
  end

  def compare_blocks
    Thread.new do
      sleep 1
      if @blocks[@open_block1].get_picture_name == @blocks[@open_block2].get_picture_name
        @removed_blocks << @open_block1
        @removed_blocks << @open_block2
        @blocks[@open_block1].destroy
        @blocks[@open_block2].destroy
        @score = @score + 1
        @label.set_score(@score)
      else
        @blocks[@open_block1].close
        @blocks[@open_block2].close
      end
      @click_counter = 0
      Message.new('ok', 'info', 'Message', 'Congratulations! You won the game') if @score == (@size * @size) / 2
    end
  end
end
