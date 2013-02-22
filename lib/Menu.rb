class Menu
  attr_reader :new_game_menu, :file_menu, :bar

  def initialize(root)
    set_new_game_menu_menu(root)
    set_file_menu_menu(root)
    set_menu_bar(root)
  end

  private

  def set_new_game_menu_menu(root)
    @new_game_menu = TkMenu.new
    @new_game_menu.add(:command, :label => 'Game 4x4')
    @new_game_menu.add(:command, :label => 'Game 6x6')
  end

  def set_file_menu_menu(root)
    @file_menu = TkMenu.new(root)
    @file_menu.add(:cascade, :label => 'New Game', :menu => @new_game_menu)
    @file_menu.add(:command, :label => 'Load Game', :state => 'disabled')
    @file_menu.add(:command, :label => "Save Game", :state => 'disabled')
    @file_menu.add(:separator)
    @file_menu.add(:command, :label => 'Exit', :command => proc { exit })
  end

  def set_menu_bar(root)
    @bar = TkMenu.new(:selectcolor => 'blue')
    @bar.add(:cascade, :menu => @file_menu, :label => 'File')
  end
end