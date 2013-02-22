class Frame
  attr_reader :frame

  def initialize(root)
    set_frame(root)
  end

  def set_frame(root)
    @frame = TkFrame.new(root,
                      :background => 'dark blue',
                      :relief => 'groove',
                      :borderwidth => 4,
                      :height => 500,
                      :width => 500
                      ).place(:x => 50, :y => 50)
  end
end