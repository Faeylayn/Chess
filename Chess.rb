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


  def king_finder(color)

    @board.each do |row|
      row.each do |space|

        next if space == " "

        kings_loccation = [row,space] if space.name == "#{color}Ki"
      end
    end

    kings_location

  end

  def check_all_enemy_movesets(kings_location,color)

    @board.each do |row|
      row.each do |space|

        next if space == " " || space.color == color

        space.generate_move_set

        return true if space.moveset.include?(kings_location)

      end
    end

    false

  end

  def dup_board

    temp_board = []

    @board.each do |row|

      new_row = []

      row.each do |space|
        new_row << space.dup
      end

      temp_board << new_row
    end

    temp_board

  end

  def in_check?(color)

    ##give us kings location
    kings_location = king_finder(color)

    ##generate move set of all enemy peices
    check_all_enemy_movesets(kings_location,color)

  end


  def make_move(start_pos, end_pos)

    moving_position = @board[start_pos[0]][start_pos[1]]
    end_position = @board[end_pos[0]][end_pos[1]]

    moving_position, end_position =  " ", moving_position

  end

end

class Game



end


a = Board.new
a.display
