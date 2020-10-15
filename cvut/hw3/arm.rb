# frozen_string_literal: true

# Top comment
class Arm
  TYPES = { poker: 1, slasher: 3, grabber: 5 }.freeze

  attr_reader :type
  attr_reader :length

  def initialize(type, length)
    raise ArgumentError, "Unknown type argument: #{type}" unless TYPES.key?(type)
    raise ArgumentError, 'Length must be > 0.' unless length.positive?

    @type = type
    @length = length
  end

  def score
    TYPES[@type]
  end
end
