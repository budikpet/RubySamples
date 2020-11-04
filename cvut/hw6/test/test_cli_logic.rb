# frozen_string_literal: true

require 'minitest/autorun'
require 'roman/cli_logic'

class TestCliLogic < Minitest::Test
  def setup
    @cli_logic = Roman::CLIlogic.new
  end

  def test_handle_arabic
    assert_equal 4, @cli_logic.handle_arabic_cmd(4)
    assert_equal 4, @cli_logic.handle_arabic_cmd('4')
    assert_equal 42, @cli_logic.handle_arabic_cmd('XLII')
    assert_equal 900, @cli_logic.handle_arabic_cmd('CM')
    assert_equal RomanClass::MAX_VALUE, @cli_logic.handle_arabic_cmd(RomanClass::MAX_VALUE)
    assert_equal RomanClass::MIN_VALUE, @cli_logic.handle_arabic_cmd(RomanClass::MIN_VALUE)

    assert_raises(ArgumentError) { @cli_logic.handle_arabic_cmd(RomanClass::MAX_VALUE + 1) }
    assert_raises(ArgumentError) { @cli_logic.handle_arabic_cmd('0') }
    assert_raises(ArgumentError) { @cli_logic.handle_arabic_cmd(0) }
    assert_raises(ArgumentError) { @cli_logic.handle_arabic_cmd('XLIIu') }
  end

  def test_handle_roman
    assert_equal 'IV', @cli_logic.handle_roman_cmd(4)
    assert_equal 'IV', @cli_logic.handle_roman_cmd('4')
    assert_equal 'XLII', @cli_logic.handle_roman_cmd('XLII')
    assert_equal 'MMMCMXCIX', @cli_logic.handle_roman_cmd(RomanClass::MAX_VALUE)
    assert_equal 'I', @cli_logic.handle_roman_cmd(RomanClass::MIN_VALUE)

    assert_raises(ArgumentError) { @cli_logic.handle_roman_cmd(RomanClass::MAX_VALUE + 1) }
    assert_raises(ArgumentError) { @cli_logic.handle_roman_cmd('0') }
    assert_raises(ArgumentError) { @cli_logic.handle_roman_cmd(0) }
    assert_raises(ArgumentError) { @cli_logic.handle_roman_cmd('XLIIu') }
  end

  # def test_that_it_will_not_blend
  #   refute_match /^no/i, @meme.will_it_blend?
  # end

  # def test_that_will_be_skipped
  #   skip "test this later"
  # end
end
