# frozen_string_literal: true

# MyStruct
class MyStruct
  attr_reader :vars

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
      @vars.to_h(&block)
    else
      @vars.to_h
    end
  end

  # Returns enumerator if no block is given
  # Yields all attributes if a block is given
  def each_pair(&block)
    return to_enum(__method__) { @vars.size } unless block_given?

    @vars.each_pair { |p| block.call(p) }
    self
  end

  ## Equals
  def eql?(other)
    return false unless other.is_a?(MyStruct)

    @vars.eql?(other.vars)
  end

  def ==(other)
    return false unless other.is_a?(MyStruct)

    @vars == other.vars
  end
end
