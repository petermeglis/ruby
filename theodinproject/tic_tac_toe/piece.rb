#
# piece.rb
#
# Author: Peter Meglis 
# Created: 4 May 2020
#

class Piece
  attr_reader :symbol

  def initialize(symbol = nil)
    @symbol = symbol
  end

  def empty?
    @symbol.nil?
  end

  def to_s
    @symbol ? "#{@symbol}" : " "
  end

end

if __FILE__ == $PROGRAM_NAME
  p1 = Piece.new
  p2 = Piece.new("X")
  p3 = Piece.new("O")

  p p1
  p p2
  p p3

  puts p1.empty?
  puts p2.empty?
end