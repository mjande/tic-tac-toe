class Board
  BLANK = ' '
  attr_accessor :board

  def initialize
    @board = Array.new(9, BLANK)
  end

  def display
    puts "#{board[0]} | #{board[1]} | #{board[2]}"
    puts '---------'
    puts "#{board[3]} | #{board[4]} | #{board[5]}"
    puts '---------'
    puts "#{board[6]} | #{board[7]} | #{board[8]}"
  end

  def update_display(row, col, player)
    case row
    when 1
      board[(col - 1)] = player
    when 2
      board[(col + 2)] = player
    when 3
      board[(col + 5)] = player
    end
    display()
  end

  def check_board_for_win(mark)
    case mark
    when board[0]
      if board[1] == mark
        board[2] == mark ? player_wins(mark) : nil
      elsif board[4]
        board[8] == mark ? player_wins(mark) : nil
      elsif board[3]
        board[6] == mark ? player_wins(mark) : nil
      end
    when board[1]
      if board[4] == mark
        board[7] == mark ? player_wins(mark) : nil
      end
    when board[2]
      if board[4] == mark
        board[6] == mark ? player_wins(mark) : nil
      elsif board[5] == mark
        board[8] == mark ? player_wins(mark) : nil
      end
    when board[3]
      if board[4] == mark
        board[5] == mark ? player_wins(mark) : nil
      end
    end
  end
end

class Player
  attr_accessor :mark
  attr_reader :num

  def initialize(num)
    @num = num
  end

  def choose_mark(other_player)
    puts 'Player 1, would you like to play X or O?'
    puts '(Type X or O to select)'
    mark = gets.chomp
    p mark
    if mark == 'X'
      other_player.mark = 'O'
    elsif mark == 'O'
      other_player.mark = 'X'
    else
      puts 'Error: Please type either X or O'
      choose_mark
    end
  end
end

player1 = Player.new(1)
player2 = Player.new(2)
newboard = Board.new

def start_game
  puts "Let's play Tic-Tac-Toe"
  newboard.display
end

def play_round(player_num)
  puts "#{player_num}, choose a row:"
  row = gets
  puts "#{player_num}, choose a column:"
  col = gets
  board.update_display
end

def player_wins
  puts 'Somebody won!'
end

start_game
newboard.check_board_for_win('X')