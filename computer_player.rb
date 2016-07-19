

class ComputerPlayer
  attr_reader :color
  def initialize(display, color)
    @display = display
    @color = color
    @board = @display.board
  end

  def make_move

    start_piece = select_start

    end_pos = select_end(start_piece)
    [start_piece.pos, end_pos]
  end




  private

  def select_start
    pieces = []
    @board.rows.each do |row|
      row.each do |piece|
        pieces << piece if piece.color == @color
      end
    end
    pieces = pieces.reject {|piece| piece.moves.empty? }

    pieces.each do |piece|
      return piece if piece.find_check_moves.length == 1
    end

    attacks = find_attacks(pieces)
    return attacks.sample unless attacks.empty?
    pieces.sample
  end

  def select_end(piece)
    return piece.find_check_moves if piece.find_check_moves == 1



    moves = piece.moves.reject do |move|
      @board[move].empty?
    end

    if moves.empty?
      piece.moves.sample
    else
      moves.sample
    end
  end

  def find_attacks(pieces)
    attacks = pieces.select do |piece|
      piece.moves.any? {|move| !@board[move].empty? }
    end
    return attacks
  end



end
