# frozen_string_literal: true

require 'bundler/setup'
Bundler.require(:default)

class Test < Thor
  desc 'example', 'an example task'
  def example
    puts "I'm a thor task!"
  end

  desc 'make_pdf', 'creates PDF'
  def make_pdf
    Prawn::Document.generate('hello.pdf') do
      text 'Hello World!'
    end
  end

  desc 'make_progress', 'creates progress bar'
  def make_progress
    progressbar = ProgressBar.create
    50.times { progressbar.increment; sleep 0.1 }
  end
end

# Test.start
puts "teat"