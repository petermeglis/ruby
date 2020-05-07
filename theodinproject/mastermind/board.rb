require_relative "row"
require_relative "peg"
require_relative "color"

class Board

  ROUNDS = 12

  def initialize
    @rows = Array.new(ROUNDS) { Row.new }
    @rows.push Row.new(pegs: Array.new(Row::SIZE) { Peg.new(filled: false) }, feedback: nil)
    @current_row_index = 0
    @current_feedback_index = 0
  end

  def initialize_code(pegs)
    @code = pegs
    @rows[-1].update_pegs(@code)
  end

  def hide_code
    @rows[-1].update_pegs(Array.new(Row::SIZE) { Peg.new(icon: "?") })
  end

  def show_code
    @rows[-1].update_pegs(@code) if @code
  end

  def get_pegs(index)
    @rows[@current_row_index]
  end

  def make_guess(pegs)
    @rows[@current_row_index].update_pegs(pegs)
    @current_row_index += 1
  end

  def add_feedback(feedback)
    @rows[@current_feedback_index].update_feedback(feedback)
    @current_feedback_index += 1
  end

  def filled?
    @current_row_index >= ROUNDS
  end

  def clear
    @rows = Array.new(12) { Row.new }
    @rows.push Row.new(pegs: Array.new(Row::SIZE) { Peg.new(icon: "?") }, feedback: nil)
    @current_row_index = 0
    @current_feedback_index = 0
  end

  def to_s
    output = "\n"
    Row::HEIGHT.times.map.with_index do |index|
      @rows.map { |row| output << row.slot_to_s(index) }
      output << "\n"
    end
    output
  end


end

if __FILE__ == $PROGRAM_NAME
  
  b = Board.new
  puts b

  b.make_guess([Peg.new(color: Color::COLORS[:yellow]),
                Peg.new(color: Color::COLORS[:red]),
                Peg.new(color: Color::COLORS[:blue]),
                Peg.new(color: Color::COLORS[:green])
                ])
  
  puts b

  b.clear

  b.make_guess([Peg.new(color: Color::COLORS[:red]),
                Peg.new(color: Color::COLORS[:purple]),
                Peg.new(color: Color::COLORS[:white]),
                Peg.new(color: Color::COLORS[:yellow])
                ])
  
  puts b

  # puts <<~HERE
  # ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
  # ░▏ ○ ▕░░▏ ○ ▕░░▏ ○ ▕░░▏ ○ ▕░░▏ ○ ▕░░▏ ○ ▕░░▏ ○ ▕░░▏ ○ ▕░░▏ ○ ▕░░▏ ○ ▕░░▏ ○ ▕░░▏ ○ ▕░░░▏ ? ▕░░
  # ░▏ ○ ▕░░▏ ○ ▕░░▏ ○ ▕░░▏ ○ ▕░░▏ ○ ▕░░▏ ○ ▕░░▏ ○ ▕░░▏ ○ ▕░░▏ ○ ▕░░▏ ○ ▕░░▏ ○ ▕░░▏ ○ ▕░░░▏ ? ▕░░
  # ░▏ ○ ▕░░▏ ○ ▕░░▏ ○ ▕░░▏ ○ ▕░░▏ ○ ▕░░▏ ○ ▕░░▏ ○ ▕░░▏ ○ ▕░░▏ ○ ▕░░▏ ○ ▕░░▏ ○ ▕░░▏ ○ ▕░░░▏ ? ▕░░
  # ░▏ ○ ▕░░▏ ○ ▕░░▏ ○ ▕░░▏ ○ ▕░░▏ ○ ▕░░▏ ○ ▕░░▏ ○ ▕░░▏ ○ ▕░░▏ ○ ▕░░▏ ○ ▕░░▏ ○ ▕░░▏ ○ ▕░░░▏ ? ▕░░
  # ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
  # ░▏○ ○▕░░▏○ ○▕░░▏○ ○▕░░▏○ ○▕░░▏○ ○▕░░▏○ ○▕░░▏○ ○▕░░▏○ ○▕░░▏○ ○▕░░▏○ ○▕░░▏○ ○▕░░▏○ ○▕░░░░░░░░░░
  # ░▏○ ○▕░░▏○ ○▕░░▏○ ○▕░░▏○ ○▕░░▏○ ○▕░░▏○ ○▕░░▏○ ○▕░░▏○ ○▕░░▏○ ○▕░░▏○ ○▕░░▏○ ○▕░░▏○ ○▕░░░░░░░░░░
  # ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
  # HERE

end