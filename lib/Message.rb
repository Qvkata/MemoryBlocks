class Message
  attr_reader :answer

  def initialize(type, icon, title, message)
    set_message_button(type, icon, title, message)
  end

  def set_message_button(type, icon, title, message)
    @answer = Tk.messageBox(:type => type,
                  :icon => icon,
                  :title => title,
                  :message => message)
  end
end