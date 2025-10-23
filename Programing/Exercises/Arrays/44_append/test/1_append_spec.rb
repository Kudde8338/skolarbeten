require_relative 'spec_helper'

FUNCTION = 'append'
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

  it 'returns ["varmkorv", "senap", "ketchup"] to input (["varmkorv", "senap"], "ketchup")' do
    StudentMethods.send(FUNCTION, ["varmkorv", "senap"], "ketchup").must_equal ["varmkorv", "senap", "ketchup"]
  end

  it 'returns [2,5,-8,7] to input ([2,5,-8], 7)' do
    StudentMethods.send(FUNCTION, [2,5,-8], 7).must_equal [2,5,-8,7]
  end

  it 'returns [2] to input ([], 2)' do
    StudentMethods.send(FUNCTION, [], 2).must_equal [2]
  end

end