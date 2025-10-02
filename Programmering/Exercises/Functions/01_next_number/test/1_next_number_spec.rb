require_relative 'spec_helper'

FUNCTION = 'next_number'
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
    assert(StudentMethods.instance_methods.include?(FUNCTION.to_sym), "Du behöver definera funktionen #{FUNCTION} i #{PATH}")
  end

  it "takes #{ARITY.humanize} argument#{ARITY > 1 ? "s" : ""}" do
    message = "Funktionen #{FUNCTION} måste ta #{ARITY} argument"
    assert_equal ARITY, method(FUNCTION.to_sym).arity, message
  end

  it 'returns 1 if input is 0' do
    next_number(0).must_equal 1
  end

  it 'returns 0 if input is -1' do
    next_number(-1).must_equal 0
  end

  it 'returns 1337 if input is 1336' do
    next_number(1336).must_equal 1337
  end

  it 'works with random input' do
    random_input = rand(1..10_000)
    next_number(random_input).must_equal random_input + 1
 end

end
