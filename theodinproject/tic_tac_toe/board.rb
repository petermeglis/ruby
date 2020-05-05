#
# board.rb
#
# Author: Peter Meglis 
# Created: 4 May 2020
#

require_relative 'piece'

class Board

  SIZE = 3

  def initialize
    @data = [[Piece.new]*SIZE, [Piece.new]*SIZE, [Piece.new]*SIZE]
  end

  def try_replace?(piece, cell)
    return false unless cell > 0 && cell <= SIZE**2
    return false unless @data[(cell - 1) / SIZE][(cell - 1) % SIZE].empty?

    @data[(cell - 1) / SIZE][(cell - 1) % SIZE] = piece
    true
  end

  def filled?
    filled_board = true
    @data.each { |row| row.each { |piece| filled_board = false if piece.empty? } }
    filled_board
  end

  def won?(symbol)
    # Check rows
    rows = @data.map do |row_data| 
      row_data.all? { |p| p.symbol == symbol }
    end

    # Check columns
    c0 = @data.map.with_index do |row_data, i| 
      row_data.filter.with_index { |p, j| j == 0}.first
    end
    c1 = @data.map.with_index do |row_data, i| 
      row_data.filter.with_index { |p, j| j == 1}.first
    end
    c2 = @data.map.with_index do |row_data, i| 
      row_data.filter.with_index { |p, j| j == 2}.first
    end

    cols = [c0, c1, c2].map do |c| 
      c.all? { |p| p.symbol == symbol }
    end
    
    # Check diagonals
    d_lr = @data.map.with_index do |row_data, i| 
      row_data.filter.with_index { |p, j| i == j}.first
    end
    d_rl = @data.map.with_index do |row_data, i| 
      row_data.filter.with_index { |p, j| j == SIZE - 1 - i}.first
    end

    diags = [d_lr, d_rl].map do |d| 
      d.all? { |p| p.symbol == symbol }
    end

    rows.any? || cols.any? || diags.any?
  end

  def display
    puts to_s
  end

  def to_s
    out = []
    SIZE.times do |i|
      out.push("#{SIZE*i+1}    |#{SIZE*i+2}    |#{SIZE*i+3}    \n")
      out.push("  #{@data[i][0]}  |  #{@data[i][1]}  |  #{@data[i][2]}  \n")
      out.push("_____|_____|_____\n")
    end
    out.pop
    out.push("     |     |     \n\n" )
    out.join
  end
end

if __FILE__ == $PROGRAM_NAME
  g = Board.new
  g.display
  g.try_replace?(Piece.new("X"),1)
  g.try_replace?(Piece.new("O"),1)
  g.try_replace?(Piece.new("X"),5)
  g.try_replace?(Piece.new("O"),4)
  g.try_replace?(Piece.new("X"),9)
  g.display
  p g.won?("X")
end