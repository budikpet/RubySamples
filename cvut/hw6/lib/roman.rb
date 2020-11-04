# frozen_string_literal: true

require_relative 'roman/cli_logic'
require 'bundler/setup'
Bundler.require(:default)

module Roman
  # Thor CLI interface for Roman CLI utility.
  class CLI < Thor
    desc '', 'Runs the Roman CLI utility.'
    method_option :arabic, type: :string, aliases: '-a', required: false, desc: 'Input is either an arabic or a roman value. Result is an arabic value. Returns an error if invalid input value is given.'
    method_option :roman, type: :string, aliases: '-r', required: false, desc: 'Input is either an arabic or a roman value. Result is a roman value. Returns an error if invalid input value is given.'
    def roman
      arabic_cmd = options[:arabic]
      roman_cmd = options[:roman]
      if arabic_cmd.nil? && roman_cmd.nil?
        CLI.command_help(Thor::Base.shell.new, 'roman')
        return
      end
      cli_logic = CLI_Logic.new
      puts cli_logic.roman_method_logic(arabic_cmd, roman_cmd)
    end

    default_task :roman
  end
end
