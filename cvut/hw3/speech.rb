# frozen_string_literal: true

# Top comment
module Speech
  LETTER_ARRAY = ('a'..'z').to_a.freeze
  def shout(text)
    res = text.upcase
    speak(res)
    res
  end

  def whisper(text)
    res = text.downcase
    speak(res)
    res
  end

  def match_char_case(new_c, c)
    if c == c.upcase
      new_c.upcase
    elsif c == c.downcase
      new_c.downcase
    end
  end

  def secret(text, shift = 3)
    shifted_chars_array = text.chars.map do |c|
      if LETTER_ARRAY.include?(c.downcase)
        index = (LETTER_ARRAY.find_index(c.downcase) + shift) % LETTER_ARRAY.size
        match_char_case(LETTER_ARRAY[index], c)
      else
        c
      end
    end

    res = shifted_chars_array * ''
    speak(res)
    res
  end
end
