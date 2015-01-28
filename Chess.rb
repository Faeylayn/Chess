##Game class and Board class
class Board

  def initialize
    @board = Array.new(8){Array.new(8) (" ")}
    initialize_pieces
  end

  def initialize_pieces

    wR = Rook.new(self, [0,0])
    @board[0][0] = wR

    wKN = Knight.new(self, [0,1])
    @board[0][1] = wKN

    wB = Bishop.new(self, [0,2])
    @board[0][2] = wB

    wQ = Queen.new(self, [0,3])
    @board[0][3] = wQ

    wKi = King.new(self,[0,4])
    @board[0][4] = wKi

    wB = Bishop.new(self, [0,5])
    @board[0][5] = wB

    wKN = Knight.new(self, [0,6])
    @board[0][6] = wKN

    wR = Rook.new (self, [0,7])
    @board[0][7] = wR

    count = 0
    7.times do
      wP = Pawn.new(self, [1,count])
      @board[1][count] = wP
      count += 1
    end

    ##########################################

    bR = Rook.new(self, [7,0])
    @board[7][0] = bR

    bKN = Knight.new(self, [7,1])
    @board[7][1] = bKN

    bB = Bishop.new(self, [7,2])
    @board[7][2] = bB

    bQ = Queen.new(self, [7,3])
    @board[7][3] = bQ

    bKi = King.new(self,[7,4])
    @board[7][4] = bKi

    bB = Bishop.new(self, [7,5])
    @board[7][5] = bB

    bKN = Knight.new(self, [7,6])
    @board[7][6] = bKN

    bR = Rook.new (self, [7,7])
    @board[7][7] = bR

    count = 0
    7.times do
      bP = Pawn.new(self, [6,count])
      @board[6][count] = bP
      count += 1
    end

  end

  def display

    @board.each do |row|
      p row
    end

  end

end
