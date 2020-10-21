# frozen_string_literal: true

# MyStruct
class MyStruct
  def initialize(input = nil)
    @vars = {}
    # Create instance attributes, getters/setters from Hash
    input&.to_h&.each_pair do |name, value|
      @vars[name.to_sym] = value
      instance_variable_set("@#{name}", value)
      self.class.send(:attr_accessor, name)
    end
  end

  def to_h(&block)
    if block_given?
      Hash[@vars.each_pair { |name, value| block.call(name, value) }]
    else
      @vars.to_h
    end
  end
end
