class Player
  attr_reader :color
  def initialize(display, color)
    @display = display
    @color = color
  end

  def make_move
    until @display.selected
      @display.get_input
      @display.render
      start_pos = @display.cursor_pos
    end

    until !@display.selected
      @display.get_input
      @display.render
      end_pos = @display.cursor_pos
    end

    [start_pos, end_pos]
  end

end
