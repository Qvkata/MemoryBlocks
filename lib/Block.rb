class Block
  BACKGROUND_IMAGE = TkPhotoImage.new(:file => 'background.gif')
  attr_reader :button, :id

  def initialize(root, id, img_name, table_size)
    @id = id
    set_button(root, id, table_size)
    set_picture(img_name, table_size)
  end

  def open
    @button.image = @picture
  end

  def close
    @button.image = BACKGROUND_IMAGE
  end

  def get_picture_name
    @picture.cget(:file)
  end

  def destroy
    @button.destroy
    @picture.destroy
  end

  #private

  def set_picture(img_name, table_size)
    @picture = TkPhotoImage.new(:file => 'resources/images' + table_size.to_s + '/' + img_name)
  end

  def set_button(root, id, table_size)
    button_size = 400 / table_size
    button_size = button_size + 10  if table_size == 6
    row = id % table_size
    column = id / table_size
    column = column / table_size - 1 if column % table_size == 0 && column != 0
    @button = TkButton.new(root, :image => BACKGROUND_IMAGE, :relief => 'raised').
                           place(:height => button_size,
                                 :width => button_size,
                                 :x => button_size * (row + 1),
                                 :y => button_size * (column + 1))
  end
end