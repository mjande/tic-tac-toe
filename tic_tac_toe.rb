# Game class data: variables and methods relating to gameplay and user
# interaction functions
class Game
  attr_accessor :player1, :player2, :win, :newboard, :player1_mark, :player2_mark

  def initialize
    @win = false
    newboard = Board.new
    @newboard = newboard
    puts "Let's play Tic-Tac-Toe"
    assign_player1
    assign_player2
  end

  def assign_player1
    puts 'Player 1: Input name below.'
    player1 = gets.chomp
    @player1 = player1
    puts 'Player 1: Would you like to play X or O?'
    player1_mark = gets.chomp
    if player1_mark.include?('X') || player1_mark.include?('O')
      @player1_mark = player1_mark
    else
      puts 'ERROR: Try again. Please select X or O.'
      assign_player1
    end
  end

  def assign_player2
    puts 'Player 2: Input name below.'
    player2 = gets.chomp
    @player2 = player2
    @player2_mark = 'X' if player1_mark == 'O'
    @player2_mark = 'O' if player1_mark == 'X'
    puts "#{player1} vs #{player2}. Let's play!"
  end

  def play_round(player, mark)
    puts "#{player}, choose a row:"
    row = gets.chomp.to_i
    puts "#{player}, choose a column:"
    col = gets.chomp.to_i
    position = convert_to_position(row, col)
    if newboard.check_board_for_position(position)
      newboard.update_display(position, mark)
    else
      play_round(player, mark)
    end
  end

  def play_game
    turn = 0
    until newboard.check_board_for_win('X') || newboard.check_board_for_win('O')
      turn += 1
      if turn.odd?
        play_round(player1, player1_mark)
      else
        play_round(player2, player2_mark)
      end
    end
    determine_winner(turn)
  end

  def convert_to_position(row, col)
    case row
    when 1
      position = col - 1
    when 2
      position = col + 2
    when 3
      position = col + 5
    end
    position
  end

  def determine_winner(turn)
    if turn.odd?
      puts "#{player1} wins!"
    elsif turn.even?
      puts "#{player2} wins!"
    end
  end
end

# Board class: variables and methods relating to the state of the board,
# including display, board array, and board checks (for win and occupied spots)
class Board < Game
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
    p position
    if board[position] == BLANK
      true
    else
      puts 'ERROR: that position is already taken'
      false
    end
  end
end

def new_game
  newgame = Game.new
  newgame.play_game
  puts 'Play again? (Y or N)'
  response = gets.chomp
  if response == 'Y'
    new_game
  else
    puts 'Thanks for playing!'
  end
end

new_game
