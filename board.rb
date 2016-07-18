load 'piece.rb'

class Board
  def initialize(grid)
    @grid = grid
  end

  def self.populate_board
    grid = Array.new(8) { Array.new(8) }
    [0, 1, 6, 7].each do |row|
      grid[row].each_with_index { |pos, col| grid[row][col] = Piece.new }
    end
    Board.new(grid)
  end

  def move(start, end_pos)
    piece = self[start]
    #change when nullpiece made to  if piece.empty?
    raise "not a piece" unless piece.is_a?(Piece)
    #update to check if piece is same or opposite team
    self[end_pos] = piece
    self[start] = nil
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

end
