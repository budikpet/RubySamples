# frozen_string_literal: true

require 'thor'
require_relative 'cli_logic'

module Roman
  # Thor CLI interface for Roman CLI utility.
  class CLI < Thor
    desc '', 'Runs the Roman CLI utility.'
    method_option :arabic, type: :string, aliases: '-a', required: false, desc: 'Input is either an arabic or a roman value. Result is an arabic value. Returns an error if invalid input value is given.'
    method_option :roman, type: :string, aliases: '-r', required: false, desc: 'Input is either an arabic or a roman value. Result is a roman value. Returns an error if invalid input value is given.'
    def roman
      puts roman_method_logic(options[:arabic], options[:roman])
    end

    default_task :roman
  end
end
