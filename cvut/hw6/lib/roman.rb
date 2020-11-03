# frozen_string_literal: true

require 'roman/version'
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
      arabic = options[:arabic]
      roman = options[:roman]
      if arabic.nil? && roman.nil?
        CLI.command_help(Thor::Base.shell.new, 'roman')
        return
      end

      puts roman_method_logic(arabic, roman)
    end

    default_task :roman
  end
end

Roman::CLI.start
