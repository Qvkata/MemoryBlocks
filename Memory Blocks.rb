require 'tk'
require_relative 'lib/GameTable'
require_relative 'lib/Menu.rb'
require_relative 'lib/Frame.rb'

class Application
  ROOT_WINDOW = TkRoot.new(:title => "Memory Blocks", :width => '600', :height => '600')

  def initialize
    @new_game_flag = true
    set_menu
    set_frame
  end

  def new_game(size)
    @menu.file_menu.entryconfigure 'Save Game', :state => 'normal'
    @menu.file_menu.entryconfigure 'Load Game', :state => 'normal'
    if @new_game_flag
      @table_size = size
      @GameTable = GameTable.new(ROOT_WINDOW, size)
      @new_game_flag = false
    else
      answer = Message.new('yesnocancel', 'question', 'Warning', 'Do you want to save the game?').answer
      if answer == 'yes'
        save_game
      elsif answer == 'no'
        @GameTable.clear_table
        @table_size = size
        @GameTable = GameTable.new(ROOT_WINDOW, size)
      end
    end
  end

  def save_game
    file_name = Tk::getSaveFile
    @GameTable.save_table(file_name) if file_name != ''
  end

  def load_game
    answer = Message.new('yesno', 'question', 'Warning', 'Do you want to save the game?').answer
    save_game if answer == 'yes'
    file_name = Tk::getOpenFile
    @GameTable.load_table(file_name) if file_name != ''
  end

  def set_frame
    Frame.new(ROOT_WINDOW)
  end

  def set_menu
    @menu = Menu.new(ROOT_WINDOW)
    @menu.new_game_menu.entryconfigure('Game 4x4', :command => proc{new_game(4)})
    @menu.new_game_menu.entryconfigure('Game 6x6', :command => proc{new_game(6)})
    @menu.file_menu.entryconfigure('Load Game', :command => proc{load_game})
    @menu.file_menu.entryconfigure('Save Game', :command => proc{save_game})
    ROOT_WINDOW.menu(@menu.bar)
  end
end

Application.new

Tk.mainloop
