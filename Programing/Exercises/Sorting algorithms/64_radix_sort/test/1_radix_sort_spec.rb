require_relative 'spec_helper'

FUNCTION = 'radix_sort'
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

  it 'returnerar [-7, 0, 2, 5] till input [0, 5, -7, 2]' do
    StudentMethods.send(FUNCTION, [0, 5, -7, 2]).must_equal [-7, 0, 2, 5]
  end
  
  it 'returnerar en sorterad array till en array med 100 slumpvis valda nummer' do
    random_array = Array.new(100) { rand(1...1000) }
    random_array_sorted = random_array.sort
    StudentMethods.send(FUNCTION, random_array).must_equal random_array_sorted
  end

  it 'Använder inte ".sort"' do
    require_relative RELATIVE_PATH
    Array.any_instance.expects(:sort).never
    StudentMethods.send(FUNCTION, [8, 2, 0, 2, 5])
  end

end

