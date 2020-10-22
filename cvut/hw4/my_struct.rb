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

  def delete_field(name)
    name = name.to_sym

    begin
      singleton_class.undef_method(name, "#{name}=".to_sym)
    rescue NameError
    end

    # Return value of the deleted variable if it exists, raise NameError otherwise
    @vars.delete(name) do
      raise NameError.new("no field `#{name}' in #{self}", name)
    end
  end

  #
  # Returns a string containing a detailed summary of the keys and values.
  #
  def inspect
    begin
      detail = @vars.map { |key, value| " #{key}=#{value.inspect}" }.join(',')
    end
    ['#<', self.class, detail, '>'].join
  end
  alias to_s inspect

  def to_h(&block)
    if block_given?
      Hash[@vars.each_pair { |name, value| block.call(name, value) }]
    else
      @vars.to_h
    end
  end
end
