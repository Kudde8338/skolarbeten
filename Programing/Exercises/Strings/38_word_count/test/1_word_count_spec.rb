require_relative 'spec_helper'

FUNCTION = 'word_count'
ARITY = 1
PATH = File.join(FUNCTION+".rb")
RELATIVE_PATH = File.join("..", PATH)
STARTING_DIR = Dir.pwd

describe FUNCTION do

  def self.test_order
    :alpha
  end

  before do
    Dir.chdir(STARTING_DIR)
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

  it 'räknar ord i enkla strängar' do
    StudentMethods.send(FUNCTION, "this is a sentence with seven words.").must_equal 7
  end

  it 'räknar ord i strängar med radbrytningar' do
    StudentMethods.send(FUNCTION, "this string has a linebreak\nwhich does not count as a space").must_equal 11
  end

  it 'hanterar strängar med mellanslag i början' do
    StudentMethods.send(FUNCTION, "  this string started with a space").must_equal 6
  end

  it 'hanterar flera mellanslag i rad och mellanslag i slutet' do
    StudentMethods.send(FUNCTION, "this string has numbers and      many spaces in a row, also space at the end. ").must_equal 15
  end

  it 'returnerar 0 för tomma strängar' do
    StudentMethods.send(FUNCTION, "").must_equal 0
  end


end
