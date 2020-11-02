# frozen_string_literal: true

require 'thor'

module Roman
  # Thor CLI interface for Roman CLI utility.
  class CLI < Thor
    desc '', 'Runs the Roman CLI utility.'
    method_option :arabic, type: :string, aliases: '-a', required: false
    method_option :roman, type: :string, aliases: '-r', required: false
    def roman
      arabic = options[:arabic]
      roman = options[:roman]
      if arabic.nil? && roman.nil?
        CLI.command_help(Thor::Base.shell.new, 'roman')
        return
      end

      puts 'Did give these options:'
      puts arabic
      puts roman
    end

    default_task :roman
  end
end
