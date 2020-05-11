require_relative "board"
require_relative "color"
require_relative "peg"
require_relative "row"

class MastermindGame

  include Color

  def initialize
    @board = Board.new
    @input_s = <<~INPUT
    Enter your four guesses (left to right --> top to bottom) e.g. >>y g r w
    #{Color::COLOR_KEY.map { |k,v| colorize(k, Color::COLORS[v]) }.join(" ") }
    #{Color::COLOR_KEY.map { |k,v| Peg.new(color: Color::COLORS[v], filled: true) }.join(" ") }

    INPUT
    @success_feedback = Array.new(Row::SIZE) { Peg.new(color: Color::COLORS[:red]) }
  end

  def play

    puts "\n"

    puts "Welcome to Mastermind on the command line!"

    code_pegs = []
    Row::SIZE.times do
      color = Color::COLORS.values[rand(Color::COLORS.values.length)]
      code_pegs.push Peg.new(color: color)
    end
    @board.initialize_code(code_pegs)
    @board.hide_code

    puts @board

    playing = true
    while playing

      puts @input_s

      guesses = []
      begin
        print ">>"
        guess = gets.chomp!
        guesses = guess.split
        raise "ERROR: Please input four letters with spaces between" unless guesses.length == 4
        raise "ERROR: Please only use valid letters for colors (r, y, g, b, p, "\
              "and w)" unless guesses.all? { |g| g.match?(/\A[rygbpw]\Z/)}
      rescue => e
        puts e
        retry
      end

      pegs = guesses.map do |g| 
        color_key = Color::COLOR_KEY[g.to_sym]
        color = Color::COLORS[color_key]
        Peg.new(color: color, filled: true)
      end

      @board.make_guess(pegs)

      feedback_pegs = create_feedback(pegs, code_pegs)
      @board.add_feedback(feedback_pegs)

      puts @board

      if feedback_pegs == @success_feedback
        puts "\n\n***You won!***\n"
        playing = false
      end
      playing = false if @board.filled?

    end

    @board.show_code
    puts @board

    puts "Thanks for playing!"
  end

  def create_feedback(pegs, code_pegs)
    feedback_pegs = []
    temp_pegs = pegs.clone
    temp_code_pegs = code_pegs.clone

    temp_pegs.each_with_index do |peg, index|
      if peg == temp_code_pegs[index]
        feedback_pegs.push Peg.new(color: Color::COLORS[:red])
        temp_code_pegs[index] = Peg.new(filled: false)
        temp_pegs[index] = Peg.new(filled: false)
      end
    end

    temp_pegs.each_with_index do |peg, index|
      if !peg.empty? && temp_code_pegs.any?(peg)
        feedback_pegs.push Peg.new(color: Color::COLORS[:white])
        found_at = temp_code_pegs.find_index(peg)
        temp_code_pegs[found_at] = Peg.new(filled: false)
        temp_pegs[index] = Peg.new(filled: false)
      end
    end

    feedback_pegs.shuffle + [Peg.new(color: Color::COLORS[:default], filled: false)] * (Row::SIZE - feedback_pegs.length)
  end

  def to_s
    @input_s
  end

end

if __FILE__ == $PROGRAM_NAME
  g = MastermindGame.new
  g.play
end
