# frozen_string_literal: true

require_relative 'robot.rb'
require_relative 'arm.rb'
require_relative 'speech.rb'

# Arm
arm = Arm.new(:poker, 39)

raise RuntimeError unless arm.length == 39
raise RuntimeError unless arm.type == :poker
raise RuntimeError unless arm.score == 1

begin
  Arm.new(:something, 9)
  raise 'Raise on arm type not working.'
rescue ArgumentError
end

begin
  arm = Arm.new(:grabber, 10)
  arm.length = 20
  raise RuntimeError unless arm.length == 10
rescue NoMethodError
end

begin
  arm = Arm.new(:grabber, 0)
  raise RuntimeError
rescue ArgumentError
end

# Robot
robot1 = Robot.new('R1')
robot1.add_arms(Arm.new(:poker, 1),
                Arm.new(:grabber, 2), Arm.new(:grabber, 2),
                Arm.new(:slasher, 2), Arm.new(:slasher, 4))

raise RuntimeError unless robot1.name == 'R1'
raise RuntimeError unless robot1.arms.length == 5
raise RuntimeError unless robot1.shout('hello') == 'HELLO'
raise RuntimeError unless robot1.whisper('Hello') == 'hello'
raise RuntimeError unless robot1.secret('abcdefg', 1) == 'bcdefgh'
raise RuntimeError unless robot1.secret('AbCdEfG', 1) == 'BcDeFgH'
raise "Robot score is #{robot1.score}" unless robot1.score == 1 + 2 * 3 + 2 * 5 + 11.fdiv(robot1.arms.length)

puts "\nIntroduction:\n"
robot1.introduce

## Compare robots
robot2 = Robot.new('R2')
robot2.add_arms(Arm.new(:poker, 1), Arm.new(:grabber, 10))

raise 'Robots should not be equal.' if robot1 == robot2
raise 'Robot1 should be greater then robot2.' unless robot1 > robot2
raise 'Incompatible types should always yield false.' if robot1 == 'hello'

begin
  robot1 = Robot.new('R')
  robot1.add_arms(Arm.new(:poker, 1), 'arm')
  raise 'Raise on Robot.add_arms not working.'
rescue ArgumentError
end

puts 'Code successful'
