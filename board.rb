require_relative 'manifest'

class Board
  def initialize(grid = Array.new(8) { Array.new(8) })
    @grid = grid
    populate_board
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

  def move(start, end_pos)
    piece = self[start]

    raise "not a piece" if piece.empty?
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





  def check_mate?
    false
  end

end
