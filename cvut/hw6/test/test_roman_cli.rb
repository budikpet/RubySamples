# frozen_string_literal: true

require 'minitest/autorun'
require 'roman'

# Tests Roman's implementation of Thor CLI
class TestRomanCLI < Minitest::Test
  def setup
    @cli = Roman::CLI_Logic.new
  end

  def test_file_command_work
    output = `./roman.rb`
    contains_roman_help?(output)
  end

  def contains_roman_help?(str)
    assert str.include? 'Usage:'
    assert str.include? 'Options:'
    assert str.include? 'Runs the Roman CLI utility.'
  end

  # def test_that_it_will_not_blend
  #   refute_match /^no/i, @meme.will_it_blend?
  # end

  # def test_that_will_be_skipped
  #   skip "test this later"
  # end
end
