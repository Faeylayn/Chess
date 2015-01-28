require_relative 'Piece'
require_relative 'Sliding_Piece'
require_relative 'Stepping_Piece'
require 'byebug'
##Game class and Board class

class CheckError < StandardError
end

class BoundsError < StandardError
end

class InvalidPieceError < StandardError
end

class CollisionError < StandardError
end

class Board
  attr_accessor :board
  def initialize
    @board = Array.new(8){ Array.new(8) {" "} }
    initialize_pieces
  end

  def initialize_pieces

      @board[0][3] = Queen.new(self, [0,3], "wQ ")
      @board[0][4] = Queen.new(self,[0,4], "wQ")
      @board[0][5] = Queen.new(self, [0,3], "wQ ")

      #@board[7][3] = Queen.new(self, [7,3], "bQ ")
      @board[7][4] = King.new(self,[7,4], "bKi")

  end

  # def initialize_pieces
  #
  #   @board[0][0] = Rook.new(self, [0,0], "wR ")
  #   @board[0][1] = Knight.new(self, [0,1], "wKN")
  #   @board[0][2] = Bishop.new(self, [0,2], "wB ")
  #   @board[0][3] = Queen.new(self, [0,3], "wQ ")
  #   @board[0][4] = King.new(self,[0,4], "wKi")
  #   @board[0][5] = Bishop.new(self, [0,5], "wB ")
  #   @board[0][6] = Knight.new(self, [0,6], "wKN")
  #   @board[0][7] = Rook.new(self, [0,7], "wR ")
  #
  #   8.times do |count|
  #     @board[1][count] = Pawn.new(self, [1,count], "wP ")
  #
  #   end
  #
  #   ##########################################
  #
  #   @board[7][0] = Rook.new(self, [7,0], "bR ")
  #   @board[7][1] = Knight.new(self, [7,1], "bKN")
  #   @board[7][2] = Bishop.new(self, [7,2], "bB ")
  #   @board[7][3] = Queen.new(self, [7,3], "bQ ")
  #   @board[7][4] = King.new(self,[7,4], "bKi")
  #   @board[7][5] = Bishop.new(self, [7,5], "bB ")
  #   @board[7][6] = Knight.new(self, [7,6], "bKN")
  #   @board[7][7] = Rook.new(self, [7,7], "bR ")
  #
  #   8.times do |count|
  #     @board[6][count] = Pawn.new(self, [6,count], "bP ")
  #
  #   end
  #
  # end

  def display
    puts "================================="
    puts "================================="
    @board.reverse.each do |row|
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

    kings_location = nil

    @board.each_with_index do |row, idx|
      row.each_with_index do |space,jdx|

        next if space == " "

        kings_location = [idx, jdx] if space.name == "#{color}Ki"

      end
    end

    kings_location

  end

  def is_threatened?(kings_location,color)

    @board.each do |row|
      row.each do |space|

        next if space == " " || space.color == color

        moveset = space.generate_move_set

        next if moveset == []

        puts space.name
        print moveset

        return true if moveset.include?(kings_location)

      end
    end

    false

  end

  def dup_board

    temp_board = Board.new
    temp_board.board = []

    @board.each do |row|

      new_row = []

      row.each do |space|
        new_row << space.dup
      end

      temp_board.board << new_row
    end

    temp_board

  end

  def in_check?(color)

    ##give us kings location
    kings_location = king_finder(color)

    ##generate move set of all enemy peices
    is_threatened?(kings_location,color)

  end

  def make_move(start_pos, end_pos)

    moving_position = @board[ start_pos[0] ] [ start_pos[1] ]

    @board[ start_pos[0] ] [ start_pos[1] ] = " "
    @board[ end_pos[0] ][ end_pos[1] ] = moving_position

  end

  def check_mate?(color)
    idx, jdx = king_finder(color)

    ##generates kings moveset
    moveset = @board[idx][jdx].generate_move_set

    print moveset

    moveset.each do |move|

      return false if !is_threatened?(move,color)

    end

    return true

  end

end

class Game

  def initialize

    @board = Board.new
    @game_on = true
    @current_color = 'w'
    play

  end

  def play

    puts "\nWelcome to Chess!\n\n"

    puts "It is now white's turn.\n"

    while @game_on

      @board.display

      puts "YOU'RE IN CHECK!" if @board.in_check?(@current_color)

      move = get_user_input

      @board.make_move(move[0], move[1])
      @board.board[move[1][0]] [move[1][1]].position = move[1]

      if @current_color == "w"
        @current_color = "b"
        puts "It is now black's turn."
      else
        @current_color = "w"
        puts "It is now white's turn."
      end

      if @board.check_mate?(@current_color)
        @game_on = false
        puts "You Lose! You get nothing! Good Day sir!"
        break
      end


    end

  end

  def get_user_input

    begin
      start_pos = get_start_piece
      end_pos = get_end_pos
      
      verify_input(start_pos, end_pos)

    rescue CollisionError
      puts "You can't move through pieces."
      retry

    rescue CheckError
      puts "That move would put you into check."
    retry

    rescue InvalidPieceError
      puts "You haven't selected one of your own pieces."
      retry

    rescue BoundsError
      puts "You have entered a position that is off the board."
      retry

    rescue StandardError
      puts "\nYou entered an invalid character. Try again."
    retry

    end

    [start_pos, end_pos]

  end

  def get_start_piece

    puts "-------------------------------------------"

      puts "\nEnter the position you wish to move from"
      start_position = gets.chomp.split("")

      start_position[0] = start_position[0].to_i
      start_position[1] = start_position[1].to_i

      if start_position.all? {|coord| coord.between?(0,7)}

          test_position = @board.board[start_position[0]][start_position[1]]

        if  test_position != ' ' && test_position.color == @current_color
          return start_position
        end

        raise InvalidPieceError

      end

      raise BoundsError

  end

  def get_end_pos

    puts "\nEnter the position you wish to move to"
    end_position = gets.chomp.split("")

    end_position[0] = end_position[0].to_i
    end_position[1] = end_position[1].to_i

    if end_position.all? {|coord| coord.between?(0,7)}

        test_position = @board.board[end_position[0]][end_position[1]]

      if  test_position == ' ' || test_position.color != @current_color
        return end_position
      end

    end

    raise CollisionError

  end

  def verify_input(start_pos, end_pos)

    target_pos = @board.board[end_pos[0]][end_pos[1]]
    moving_piece = @board.board[start_pos[0]][start_pos[1]]
    moveset = moving_piece.generate_move_set

    raise CheckError if moving_piece.move_into_check?(end_pos)

    return true if moveset.include?(end_pos)

    raise StandardError

  end
end

a = Game.new
