require_relative 'display'
require_relative 'player'

class Game

  def initialize(board, display, player)
    @board = board
    @display = display
    @player = player
  end

  def over?
    @board.check_mate?
  end

  def play
    until over?
      @display.render
      move = @player.make_move
      move_first, move_last = move
      @board.move(move_first, move_last)
    end
  end


end





if __FILE__ == $PROGRAM_NAME

  b=Board.new
  d = Display.new(b)
  play = Player.new(d)
  g = Game.new(b, d, play)

  g.play



end
