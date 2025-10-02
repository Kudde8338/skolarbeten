require_relative 'spec_helper'

FUNCTION = 'chomp'
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

  it 'returns the string if the string does not end with a linebreak' do
    StudentMethods.send(FUNCTION, "HellO").must_equal "HellO"
    StudentMethods.send(FUNCTION, "hello").must_equal "hello"
  end

  it 'returns a new string with the linebreak removed if the string ends with a linebreak' do
    StudentMethods.send(FUNCTION, "HellO\n").must_equal "HellO"
    StudentMethods.send(FUNCTION, "hello\n").must_equal "hello"
  end

  it 'does not remove linebreaks in the middle or beginning of strings' do
    StudentMethods.send(FUNCTION, "HellO\nWorld").must_equal "HellO\nWorld"
    StudentMethods.send(FUNCTION, "\nhello\n").must_equal "\nhello"
  end
  
  it 'does not use the built in chomp method' do
    String.any_instance.expects(:chomp).never
    StudentMethods.send(FUNCTION, "hello\n").must_equal "hello"
  end

end