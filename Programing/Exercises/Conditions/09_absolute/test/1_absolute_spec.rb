require_relative 'spec_helper'

FUNCTION = 'absolute'
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

  it 'beräknar absolutbeloppet av ett positivt tal' do
    absolute(3).must_equal 3
    absolute(3.7).must_equal 3.7
  end

  it 'beräknar absolutbeloppet av ett negativt tal' do
    absolute(-783).must_equal 783
    absolute(-233.7).must_equal 233.7
  end

  it 'beräknar absolutbeloppet av 0' do
    absolute(0).must_equal 0
  end

  it 'använder INTE Math.sqrt' do
    Math.expects(:sqrt).never
    absolute(3).must_equal 3
  end

end