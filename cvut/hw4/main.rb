# frozen_string_literal: true

require_relative 'my_struct'

hash = { 'country' => 'Australia', :capital => 'Canberra' }
s_hash = MyStruct.new(hash)                                     # input is hash
s_inline = MyStruct.new('name' => 'Rowdy', :age => nil)         # input is hash
s_my_struct = MyStruct.new(s_hash)                              # input is MyStruct

puts s_hash.country
puts s_inline.name
puts s_my_struct.country

new_h = s_hash.to_h do |name, value|
  [name.to_s, value.upcase]
end
puts new_h

# DELETE_FIELD TEST
raise 'Should return a value of the deleted instance variable.' unless s_hash.delete_field('country') == 'Australia'

begin
  puts s_hash.country
  raise 'Accessors for country were not removed.'
rescue NoMethodError
end

begin
  s_hash.delete_field('country')
  raise 'Should raise error since country is no longer part of the object.'
rescue NameError => e
  puts e.message
end
