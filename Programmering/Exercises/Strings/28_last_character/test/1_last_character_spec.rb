require_relative 'spec_helper'

FUNCTION = 'last_character'
ARITY = 1
PATH = File.join(FUNCTION+".rb")
RELATIVE_PATH = File.join("..", PATH)

describe FUNCTION do
  
  def self.test_order
    :alpha
  end

  module StudentMethods; end

  def wrap_function_in_namespace
      StudentMethods.module_eval(File.read(PATH), __FILE__, __LINE__)
  end

  it 'exists' do
    assert File.exist?(PATH), "Du behöver skapa filen #{PATH}"
    require_relative RELATIVE_PATH
  end
  
  it "has a function named #{FUNCTION}" do
wrap_function_in_namespace
    assert(StudentMethods.instance_methods.include?(FUNCTION.to_sym),
               "Du behöver definera funktionen #{FUNCTION} i #{PATH}")  end
  
  it "takes #{ARITY.humanize} argument#{ARITY > 1 ? "s" : ""}" do
    message = "Funktionen #{FUNCTION} måste ta #{ARITY} argument"
    assert_equal ARITY, method(FUNCTION.to_sym).arity, message
  end

  it 'returns the last character when the string is not empty' do
    StudentMethods.send(FUNCTION, "BANAN").must_equal "N"
    StudentMethods.send(FUNCTION, "banan").must_equal "n"
    StudentMethods.send(FUNCTION, "   OooooOooooOoooo   ").must_equal " "
  end

  it 'returns nil if the string is empty' do
    StudentMethods.send(FUNCTION, "").must_equal nil
  end

end