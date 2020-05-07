module Color
  
  COLORS = {
    red: "\e[31m",
    yellow: "\e[33m",
    green: "\e[32m",
    blue: "\e[34m",
    purple: "\e[35m",
    white: "\e[37m",
    default: "\e[0m"
  }

  COLOR_KEY = {
    r: :red,
    y: :yellow,
    g: :green,
    b: :blue,
    p: :purple,
    w: :white
  }

  def colorize(text, color)
    return "#{color}#{text}#{COLORS[:default]}"
  end
end

if __FILE__ == $PROGRAM_NAME
  include Color

  puts colorize("\u2588", COLORS[:red])
  puts colorize("\u2588", COLORS[:yellow])
  puts colorize("\u2588", COLORS[:green])
  puts colorize("\u2588", COLORS[:blue])
  puts colorize("\u2588", COLORS[:purple])
  puts colorize("\u2588", COLORS[:white])
  puts colorize("\u2588", COLORS[:default])
end
