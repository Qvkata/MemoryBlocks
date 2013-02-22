class Label
  attr_reader :label

  def initialize(root, score)
    set_label(root, score)
  end

  def set_score(new_score)
    @label.text = 'SCORE: ' + new_score.to_s
  end

  private

  def set_label(root, score)
    font = TkFont.new(:family => 'Helvetica',
                      :size => 20,
                      :weight => 'bold')
    @label = TkLabel.new(root,
                         :text =>'SCORE: ' + score.to_s,
                         :borderwidth => 5,
                         :font => font,
                         :foreground  => "red",
                         :relief => "groove"
                         ).place(:width => 300, :height => 50, :x => 150, :y=>1)
  end
end