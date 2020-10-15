# frozen_string_literal: true

require_relative 'speech.rb'
require_relative 'arm.rb'

# Top comment
class Robot
  include Comparable
  include Speech

  attr_reader :name

  def initialize(name)
    @name = name
    @arms = {}
  end

  def arms
    @arms.values.flatten
  end

  def add_arms(*new_arms)
    new_arms.each do |arm|
      unless arm.respond_to?(:score) && arm.respond_to?(:length)
        raise ArgumentError, "Should have gotten object of Arm, instead got #{arm}"
      end

      if @arms.key?(arm.type)
        @arms[arm.type].push(arm)
      else
        @arms[arm.type] = [arm]
      end
    end
  end

  def score
    arms_arr = arms
    score_sum = arms_arr.inject(0) { |sum, arm| sum + arm.score }
    avg_length = arms_arr.inject(0) { |sum, arm| sum + arm.length }.fdiv(arms_arr.length)
    score_sum + avg_length
  end

  def <=>(other)
    return nil unless other.respond_to? :score

    score <=> other.score
  end

  def speak(text)
    puts text
  end

  def introduce
    puts "Name: #{@name}"
    puts 'Arms: '
    @arms.keys.each do |type|
      arr = @arms[type]
      continue if arr.empty?
      puts "\t#{type}: #{arr.length}"
    end
  end
end
