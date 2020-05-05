#
# player.rb
#
# Author: Peter Meglis 
# Created: 4 May 2020
#

class Player
  attr_reader :id, :symbol

  def initialize(id, symbol)
    @id = id
    @symbol = symbol
  end

  def to_s
    "Player #{@id}, #{@symbol}'s"
  end

end

if __FILE__ == $PROGRAM_NAME
  py1 = Player.new(1, "X")
  py2 = Player.new(2, "O")
  
  puts py1
  puts py2

  puts py1.symbol
  puts py2.symbol
end