# frozen_string_literal: true

require 'thor'

module Roman
  # Thor CLI interface for Roman CLI utility.
  class CLI < Thor
    desc 'run', 'Runs the Roman CLI utility.'
    def self.run(*args)
      puts 'Lorem Ipsum blah blah blah'
      puts args
    end
  end
end
