require_relative 'manifest'
require 'byebug'

class Board
  

  def initialize(grid = Array.new(8) { Array.new(8) })
    @grid = grid
    populate_board
  end


  def move(start, end_pos)
    piece = self[start]
    if piece.moves.include?(end_pos)
      self[end_pos] = piece
      piece.pos = end_pos
      self[start] = NullPiece.instance
    else
      raise "invalid move"
    end
  end

  def in_bounds?(pos)
    pos.all? { |x| x.between?(0, 7) }
  end

  def game_over?
    check_mate?(:white) || check_mate?(:black)
  end


  def rows
    @grid
  end

  def [](pos)
    row, col = pos
    @grid[row][col]
  end

  def []=(pos, mark)
    row, col = pos
    @grid[row][col] = mark
  end

  protected

  def in_check?(color)
    king_pos = find_king(color)
    oppenent_color = (color == :white ? :black : :white)
    @grid.each do |row|
      row.each do |piece|
        if piece.color == oppenent_color
          return true if piece.moves.include?(king_pos)
        end
      end
    end
    false
  end
  private

  def find_king(color)
    @grid.each do |row|
      row.each do |piece|
        return piece.pos if piece.color == color && piece.class == King
      end
    end
  end

  def check_mate?(color)
    # debugger
    return false unless in_check?(color)
    @grid.each_with_index do |row, row_idx|
      row.each_with_index do |piece, col_idx|
        next unless piece.color == color
        piece.moves.each do |move|
          dup_board = dup
          dup_board.move([row_idx, col_idx], move)
          return false unless dup_board.in_check?(color)
        end
      end
    end
    true
  end


  def dup
    new_board = Board.new
    @grid.each_with_index do |row, row_idx|
      row.each_with_index do |piece, col_idx|
        new_board[[row_idx, col_idx]] = piece.dup(new_board)
      end
    end
    new_board
  end



  def populate_board
    (2..5).each do |row|
      @grid[row].each_with_index { |pos, col| @grid[row][col] = NullPiece.instance }
    end
    pawn_rows
    main_rows
  end

  def pawn_rows
    color = :black
    [1, 6].each do |row|
      @grid[row].each_with_index { |pos, col| @grid[row][col] = Pawn.new([row,col], color, self) }
      color = :white
    end
  end

  def main_rows
    top_pieces = [
      Rook.new(nil, :black, self),
      Knight.new(nil, :black, self),
      Bishop.new(nil, :black, self),
      Queen.new(nil, :black, self),
      King.new(nil, :black, self),
      Bishop.new(nil, :black, self),
      Knight.new(nil, :black, self),
      Rook.new(nil, :black, self)
    ]
    bottom_pieces = [
      Rook.new(nil, :white, self),
      Knight.new(nil, :white, self),
      Bishop.new(nil, :white, self),
      Queen.new(nil, :white, self),
      King.new(nil, :white, self),
      Bishop.new(nil, :white, self),
      Knight.new(nil, :white, self),
      Rook.new(nil, :white, self)
    ]
    pieces = top_pieces
    [0, 7].each do |row|
      @grid[row].each_with_index do |el, col|
        piece = pieces[col]
        piece.pos = [row, col]
        @grid[row][col] = piece
      end
      pieces = bottom_pieces
    end
  end

end
