require_relative 'spec_helper'

FUNCTION = 'length'
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

  it 'returns 0 when string is empty' do
    StudentMethods.send(FUNCTION, "").must_equal 0
  end

  it 'returns 1 when string length is 1' do
    StudentMethods.send(FUNCTION, "1").must_equal 1
  end

  it 'returns the correct length for longer strings' do
    StudentMethods.send(FUNCTION, "1234").must_equal 4
    StudentMethods.send(FUNCTION, "1234567891 ").must_equal 11
    StudentMethods.send(FUNCTION, "123").must_equal 3
    StudentMethods.send(FUNCTION, "                    ").must_equal 20
  end

  it 'returns the correct length when string contains linebreaks' do
    str = "Hello
    
    World"
    StudentMethods.send(FUNCTION, str).must_equal str.length
  end

  it 'does not use the built in length functions' do
      String.any_instance.expects(:length).never
      String.any_instance.expects(:size).never
      String.any_instance.expects(:count).never
      StudentMethods.send(FUNCTION, "hello").must_equal 5
  end

end