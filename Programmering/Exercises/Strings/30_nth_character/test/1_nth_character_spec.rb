require_relative 'spec_helper'

FUNCTION = 'nth_character'
ARITY = 2
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

  it 'returns the first character if position is 1' do
    StudentMethods.send(FUNCTION, "ABCDEFG", 1).must_equal "A"
    StudentMethods.send(FUNCTION, "GHIJKLM", 1).must_equal "G"
  end

  it 'returns the 3rd character if position is 3' do
    StudentMethods.send(FUNCTION, "ABCDEFG", 3).must_equal "C"
    StudentMethods.send(FUNCTION, "GHIJKLM", 3).must_equal "I"
  end

  it 'returns nil if the string is empty' do
    StudentMethods.send(FUNCTION, "", 0).must_equal nil
    StudentMethods.send(FUNCTION, "", 1).must_equal nil
    StudentMethods.send(FUNCTION, "", 3).must_equal nil
  end

  it 'returns nil if position is 0' do
    StudentMethods.send(FUNCTION, "string", 0).must_equal nil
  end


end
