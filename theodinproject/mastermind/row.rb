require_relative "peg"

class Row

  SIZE = 4
  HEIGHT = 1 + SIZE + 1 + (SIZE / 2) + 1

  def initialize(pegs: Array.new(SIZE) { Peg.new(filled: false) }, feedback: Array.new(SIZE) { Peg.new(filled: false) })
    @pegs = pegs
    @feedback = feedback
    @row_a = row_to_a
  end

  def update_pegs(pegs)
    @pegs = pegs
    @row_a = row_to_a
  end

  def update_feedback(feedback)
    @feedback = feedback
    @row_a = row_to_a
  end

  def row_to_a
    temp = []
    temp << "░░░░░░░"
    temp << "░▏ #{@pegs[0]} ▕░"
    temp << "░▏ #{@pegs[1]} ▕░"
    temp << "░▏ #{@pegs[2]} ▕░"
    temp << "░▏ #{@pegs[3]} ▕░"
    temp << "░░░░░░░"
    if @feedback
      temp << "░▏#{@feedback[0]} #{@feedback[1]}▕░"
      temp << "░▏#{@feedback[2]} #{@feedback[3]}▕░"
    else
      temp << "░░░░░░░"
      temp << "░░░░░░░"
    end
    temp << "░░░░░░░"
    temp
  end

  def slot_to_s(index)
    return nil if index < 0 || index >= @row_a.length
    @row_a[index]
  end

  def to_s
    @row_a.join("\n")
  end

end

if __FILE__ == $PROGRAM_NAME

  r1 = Row.new
  # puts r1
  # puts r1.slot_to_s(0)
  r2 = Row.new
  # puts r2
  r3 = Row.new(pegs: Array.new(Row::SIZE) { Peg.new(icon: "?") }, feedback: nil)

  output = ""
  Row::HEIGHT.times.map.with_index do |index|
    [r1,r2,r3].map { |row| output << row.slot_to_s(index) }
    output << "\n"
  end
  puts output

end