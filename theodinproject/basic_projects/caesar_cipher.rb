def caesar_cipher(string, shift_factor)
  string.chars.reduce("") do |encrypted, char| 
    ascii_char = char.ord
    if ascii_char >= 'a'.ord && ascii_char <= 'z'.ord 
      ascii_char = (ascii_char - 'a'.ord + shift_factor) % 26 + 'a'.ord
    elsif ascii_char >= 'A'.ord && ascii_char <= 'Z'.ord 
      ascii_char = (ascii_char - 'A'.ord + shift_factor) % 26 + 'A'.ord
    end
    encrypted << ascii_char.chr
  end
end

caesar_cipher("What a string!", 5)