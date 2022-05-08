require_relative 'board'

# Game class data: variables and methods relating to gameplay and user
# interaction functions
class Game
  attr_accessor :player1, :player2, :win, :newboard, :player1_mark, :player2_mark

  def start_game
    @win = false
    newboard = Board.new
    @newboard = newboard
    puts "Let's play Tic-Tac-Toe"
    assign_player1
    assign_player2
    play_game
  end
  
  def assign_player1
    puts 'Player 1: Input name below.'
    @player1 = gets.chomp
    @player1_mark = choose_mark
  end

  def choose_mark 
    loop do
      puts 'Player 1: Would you like to play X or O?'
      mark = gets.chomp.upcase.strip
      responses = ['X', 'O']
      return mark if responses.include(mark)

      puts 'ERROR: Try again. Please select X or O.'
    end
  end

  def assign_player2
    puts 'Player 2: Input name below.'
    player2 = gets.chomp
    @player2 = player2
    @player2_mark = 'X' if @player1_mark == 'O'
    @player2_mark = 'O' if @player1_mark == 'X'
    puts "#{player1} vs #{player2}. Let's play!"
  end

  def play_round(player, mark)
    puts "#{player}, choose a row:"
    row = gets.chomp.to_i
    puts "#{player}, choose a column:"
    col = gets.chomp.to_i
    position = convert_to_position(row, col)
    if @newboard.check_board_for_position(position)
      @newboard.update_display(position, mark)
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
    play_again
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

  def play_again
    if again == true
      puts 'Play again? (Y or N)'
      response = gets.chomp
    end
    if response == 'N'
      puts 'Thanks for playing!'
    else 
      start_game
    end
  end
end