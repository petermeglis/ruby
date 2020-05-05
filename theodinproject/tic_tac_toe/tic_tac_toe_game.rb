#
# tic_tac_toe_game.rb
#
# Author: Peter Meglis 
# Created: 4 May 2020
#

require_relative "player"
require_relative "board"
require_relative "piece"

class TicTacToeGame

  def initialize(p1_symbol = nil, p2_symbol = nil)
    player1 = Player.new(1, p1_symbol)
    player2 = Player.new(2, p2_symbol)
    @players = [player1, player2]

    @setup = p1_symbol && p2_symbol ? true : false
  end


  def setup_cli
    puts "Welcome to Tic Tac Toe!"

    # Set up player 1
    p1_symbol = nil
    loop do
      puts "Player 1, what symbol are you? (X or O)"
      p1_symbol = gets.chomp!
      break if p1_symbol.match?(/\A[a-zA-Z]\z/)
      puts "Please enter a valid letter"
    end
    player1 = Player.new(1, p1_symbol)

    # Set up player 2
    p2_symbol = nil
    loop do
      puts "Player 2, what symbol are you?"
      p2_symbol = gets.chomp!
      break if p2_symbol.match?(/\A[a-zA-Z]\z/) && p2_symbol != p1_symbol
      puts "Please enter a valid letter that is not Player 1's letter"
    end
    player2 = Player.new(2, p2_symbol)

    @players = [player1, player2]

    puts "\n"

    3.times do |i|
      printf("\rSetting up the board%s", "."*(i+1))
      sleep(0.25)
    end

    @setup = true
  end

  def play
    setup_cli unless @setup

    puts "\n"

    board = Board.new
    board.display

    counter = rand(2)
    winning_player = nil

    until winning_player || board.filled?
      player = @players[counter % @players.length]
      puts "#{player}, it's your turn."
      cell = nil
      begin
        print "Cell number: "
        cell = Integer(gets.chomp)
        raise "Error: Integer not between 1 and 9" if cell < 1 || cell > 9
        raise "Error: Cell occupied" unless board.try_replace?(Piece.new(player.symbol), cell)
      rescue => e
        puts e.is_a?(ArgumentError) ? "Error: Invalid integer" : e
        puts "Please enter a valid empty cell integer (1 through 9)"
        retry
      end

      puts "\n"
      
      board.display

      winning_player = player if board.won?(player.symbol)
      counter += 1
    end

    puts "#{winning_player}, you won!!" if winning_player
    puts "It's a tie!" if !winning_player && board.filled?

    puts "\n"

    print "Play again? [y/n]"
    response = gets.chomp
    case response
    when "y"
      play
    when "Y"
      play
    else
      puts "Thanks for playing!"
    end
  end

end


if __FILE__ == $PROGRAM_NAME
  # Quick start, comment this out if you use the custom symbols
  g = TicTacToeGame.new("X", "O")

  # Custom symbol choices, uncomment this instead:
  # g = TicTacToeGame.new
  
  g.play
end