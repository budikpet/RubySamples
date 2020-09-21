# frozen_string_literal: true

res = (1..100).map do |val|
  res = if (val % 15).zero?
          'Fizz Buzz'
        elsif (val % 5).zero?
          'Fizz'
        elsif (val % 3).zero?
          'Buzz'
        else
          val.to_s
        end

  res
end * ', '

print res
