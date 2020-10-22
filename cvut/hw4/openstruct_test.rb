# frozen_string_literal: true

require 'ostruct'

person = OpenStruct.new(name: 'John', age: 70, pension: 300)

person.delete_field('name')   # => 70
person

begin
  person.delete_field('name')
  raise 'Should raise error since country is no longer part of the object.'
rescue NameError => e
  puts e.message
end
