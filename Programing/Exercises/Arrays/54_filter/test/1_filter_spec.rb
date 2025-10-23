require_relative 'spec_helper'

FUNCTION = 'filter'
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

  it 'Använder inte ".map"' do
    require_relative RELATIVE_PATH
    Array.any_instance.expects(:method).with(regexp_matches(/map/)).never
    StudentMethods.send(FUNCTION, [8, 2, 0, 2, 5], 2)
  end

  it 'Använder inte ".select"' do
    require_relative RELATIVE_PATH
    Array.any_instance.expects(:select).never
    StudentMethods.send(FUNCTION, [8, 2, 0, 2, 5], 2)
  end

  it 'Använder inte ".reject"' do
    require_relative RELATIVE_PATH
    Array.any_instance.expects(:method).with(regexp_matches(/reject/)).never
    StudentMethods.send(FUNCTION, [8, 2, 0, 2, 5], 2)
  end

it 'returnerar [2, 2] till input ([8, 2, 0, 2, 5], 2)' do
    StudentMethods.send(FUNCTION, [8, 2, 0, 2, 5], 2).must_equal [2, 2]
  end
  
  it 'returnerar [] till input ([8, 2, 0, 2, 5], "2")' do
    StudentMethods.send(FUNCTION, [8, 2, 0, 2, 5], "2").must_equal []
  end

  it 'returnerar ["olof", "olof", "olof"] till input (["bosse", "olof", "olof", "kalle", "olof"], "olof")' do
    StudentMethods.send(FUNCTION, ["bosse", "olof", "olof", "kalle", "olof"], "olof").must_equal ["olof", "olof", "olof"]
  end

end