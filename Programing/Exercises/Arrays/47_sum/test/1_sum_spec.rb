require_relative 'spec_helper'

FUNCTION = 'sum'
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

  it 'Använder inte ".sum"' do
    require_relative RELATIVE_PATH
    Array.any_instance.expects(:sum).never
    StudentMethods.send(FUNCTION, [1, 2, 3, 4, 5])
  end

  it 'returnerar 15 till input [1, 2, 3, 4, 5]' do
    StudentMethods.send(FUNCTION, [1, 2, 3, 4, 5]).must_equal 15
  end

  it 'returnerar 4011 till input [1337, 1337, 1337]' do
    StudentMethods.send(FUNCTION, [1337, 1337, 1337]).must_equal 4011
  end

  it 'returnerar -2145394 till input [-2150714, 9558, -4741, -38, 0, 541]' do
    StudentMethods.send(FUNCTION, [-2150714, 9558, -4741, -38, 0, 541]).must_equal -2145394
  end

end