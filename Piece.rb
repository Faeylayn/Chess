# peice class

class Piece

  attr_accessor :position, :color, :name

  HORIZONTAL_STEPS = [
    [1,0],
    [-1,0]
  ]

  VERTICAL_STEPS = [
    [0,1],
    [0,-1]
  ]

  DIAGONAL_STEPS = [
    [1,1],
    [1,-1],
    [-1,1],
    [-1,-1]
  ]

  def initialize(board, starting_position, name)
    @position = starting_position
    @color = name[0]
    @moveset = []
    @board = board
    @name = name
  end

  def valid_move?(position)
    position.all? {|coord| coord.between?(0,7)}
  end

  def make_move(move_position)
    @position = move_position
  end

end
