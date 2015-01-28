# peice class

class Piece

  attr_accessor :position, :color, :name, :moveset

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

  def move_into_check?(position)

    test_board = @board.dup_board

    test_board.make_move(@position, position)

    test_board.in_check?(@color)

  end

end
