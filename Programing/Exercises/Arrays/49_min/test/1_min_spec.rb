require_relative 'spec_helper'

FUNCTION = 'min'
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

  it 'Använder inte ".min"' do
    require_relative RELATIVE_PATH
    Array.any_instance.expects(:min).never
    StudentMethods.send(FUNCTION, [1, 2, 3, 4, 5])
  end


  it 'returnerar 3 till input [11, 20, 3, 4, 4]' do
    StudentMethods.send(FUNCTION, [11, 20, 3, 4, 4]).must_equal 3
  end

  it 'returnerar 1337 till input [1337, 1337, 1337]' do
    StudentMethods.send(FUNCTION, [1337, 1337, 1337]).must_equal 1337
  end

  it 'returnerar -47 till input [1337, 54150, -47, 58.2]' do
    StudentMethods.send(FUNCTION, [1337, 54150, -47, 58.2]).must_equal -47
  end

  it 'returnerar 5.3 till input [44, 7.8, 78, 5.3, 100]' do
    StudentMethods.send(FUNCTION, [44, 7.8, 78, 5.3, 100]).must_equal 5.3
  end

end