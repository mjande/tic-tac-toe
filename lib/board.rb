require_relative 'game'

# Board class: variables and methods relating to the state of the board,
# including display, board array, and board checks (for win and occupied spots)
class Board
  BLANK = ' '
  attr_accessor :board

  def initialize
    @board = Array.new(9, BLANK)
  end

  def display_board
    puts "#{board[0]} | #{board[1]} | #{board[2]}"
    puts '---------'
    puts "#{board[3]} | #{board[4]} | #{board[5]}"
    puts '---------'
    puts "#{board[6]} | #{board[7]} | #{board[8]}"
  end

  def update_display(position, mark)
    board[position.to_i] = mark
    display_board
  end

  def check_board_for_win(mark)
    case mark
    when board[0]
      if board[1] == mark
        board[2] == mark
      elsif board[4]
        board[8] == mark
      elsif board[3]
        board[6] == mark
      end
    when board[1]
      if board[4] == mark
        board[7] == mark
      end
    when board[2]
      if board[4] == mark
        board[6] == mark
      elsif board[5] == mark
        board[8] == mark
      end
    when board[3]
      if board[4] == mark
        board[5] == mark
      end
    when board[6]
      if board[7] == mark
        board[8] == mark
      end
    end
  end

  def check_board_for_position(position)
    if board[position] == BLANK
      true
    else
      puts 'ERROR: that position is already taken'
      false
    end
  end
end