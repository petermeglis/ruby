require_relative "color"

class Peg

  include Color

  attr_reader :color, :filled, :icon

  def initialize(color: COLORS[:default], filled: true, icon: nil)
    @color = color
    @filled = filled
    if icon 
      @icon = icon 
    else 
      @icon = (filled ? "\u25CF" : "\u25CB")
    end
  end

  def to_s
    colorize(@icon.encode('utf-8'), @color)
  end

  def ==(other)
    @color == other.color && @filled == other.filled && @icon == other.icon
  end

  def empty?
    !@filled
  end

end

if __FILE__ == $PROGRAM_NAME
  include Color

  puts Peg.new(color: COLORS[:red])
  puts Peg.new(color: COLORS[:yellow])
  puts Peg.new(color: COLORS[:green])
  puts Peg.new(color: COLORS[:blue])
  puts Peg.new(color: COLORS[:purple])
  puts Peg.new(color: COLORS[:white])
  puts Peg.new(color: COLORS[:default]) 
  puts Peg.new
  puts Peg.new(filled: false)
  puts Peg.new(icon: "?")

  p1 = Peg.new(color: COLORS[:white])
  p2 = Peg.new(color: COLORS[:white])
  puts p1 == p2

  p3 = Peg.new(color: COLORS[:white])
  p4 = Peg.new(color: COLORS[:red])
  puts p3 == p4

end