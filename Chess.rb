require_relative 'Piece'
require_relative 'Sliding_Piece'
require_relative 'Stepping_Piece'

##Game class and Board class
class Board

  def initialize
    @board = Array.new(8){ Array.new(8) {" "} }
    initialize_pieces
  end

  def initialize_pieces

    @board[0][0] = Rook.new(self, [0,0], "wR ")


    @board[0][1] = Knight.new(self, [0,1], "wKN")


    @board[0][2] = Bishop.new(self, [0,2], "wB ")


    @board[0][3] = Queen.new(self, [0,3], "wQ ")


    @board[0][4] = King.new(self,[0,4], "wKi")


    @board[0][5] = Bishop.new(self, [0,5], "wB ")


    @board[0][6] = Knight.new(self, [0,6], "wKN")


    @board[0][7] = Rook.new(self, [0,7], "wR ")


    8.times do |count|
      @board[1][count] = Pawn.new(self, [1,count], "wP ")

    end

    ##########################################

    @board[7][0] = Rook.new(self, [7,0], "bR ")


    @board[7][1] = Knight.new(self, [7,1], "bKN")


    @board[7][2] = Bishop.new(self, [7,2], "bB ")


    @board[7][3] = Queen.new(self, [7,3], "bQ ")


    @board[7][4] = King.new(self,[7,4], "bKi")


    @board[7][5] = Bishop.new(self, [7,5], "bB ")


    @board[7][6] = Knight.new(self, [7,6], "bKN")


    @board[7][7] = Rook.new(self, [7,7], "bR ")


    8.times do |count|
      @board[6][count] = Pawn.new(self, [6,count], "bP ")

    end

  end

  def display
    puts
    @board.each do |row|
      row.each do |space|
        print " "
        print "___" if space == " "
        print space.name if space != " "
      end
      puts ' '
    end
    puts
  end

end


a = Board.new
a.display
