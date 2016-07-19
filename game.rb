require_relative 'display'
require_relative 'player'
require_relative 'computer_player'

class Game

  def initialize(board, display, player_one, player_two)
    @current_player = player_one
    @player_one = player_one
    @player_two = player_two
    @board = board
    @display = display
  end


  def play
    # @board.move([6, 5], [5, 5])
    # @board.move([1, 4], [3, 4])
    # @board.move([6, 6], [4, 6])
    until over?
      begin
        @display.render
        puts "current player is #{@current_player.color}"
        move = @current_player.make_move
        move_first, move_last = move
        raise "Not a piece" if @board[move_first].empty?
        raise "You are cheating" unless @board[move_first].color == @current_player.color
        @board.move(move_first, move_last)
      rescue => e
        puts e.message
        sleep(1)
        retry
      end
      swap_players
    end
  end

  private

  def over?
    @board.game_over?
  end

  def swap_players
    @current_player = (@current_player == @player_one ?
    @player_two : @player_one)
  end


end





if __FILE__ == $PROGRAM_NAME

  b=Board.new
  d = Display.new(b)
  play2 = Player.new(d, :black)
  play1 = Player.new(d, :white)
  g = Game.new(b, d, play1, play2)
  g.play

  # @board.move([0, 3], [5, 7])



end
