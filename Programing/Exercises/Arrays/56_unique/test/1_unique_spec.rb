require_relative 'spec_helper'

FUNCTION = 'unique'
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

  it 'Använder inte ".uniq"' do
    require_relative RELATIVE_PATH
    Array.any_instance.expects(:uniq).never
    StudentMethods.send(FUNCTION, [8, 2, 0, 2, 5])
  end

  it 'Använder inte ".include?"' do
    require_relative RELATIVE_PATH
    Array.any_instance.expects(:include?).never
    StudentMethods.send(FUNCTION, [8, 2, 0, 2, 5])
  end

  it "takes #{ARITY.humanize} argument#{ARITY > 1 ? "s" : ""}" do
    message = "Funktionen #{FUNCTION} måste ta #{ARITY} argument"
    assert_equal ARITY, StudentMethods.method(FUNCTION.to_sym).arity, message
  end

  it 'returnerar [8, 2, 0, 5] till input [8, 2, 0, 2, 5]' do
    StudentMethods.send(FUNCTION, [8, 2, 0, 2, 5]).must_equal [8, 2, 0, 5]
  end

  it 'returnerar ["ketchup", "senap", "varmkorv"] till input ["ketchup", "ketchup", "senap", "varmkorv", "ketchup", "senap"]' do
    StudentMethods.send(FUNCTION, ["ketchup", "ketchup", "senap", "varmkorv", "ketchup", "senap"]).must_equal ["ketchup", "senap", "varmkorv"]
  end

  it 'returnerar [true, "true", [true]] till input [true, "true", true, "true", [true], true, [true]]' do
    StudentMethods.send(FUNCTION, [true, "true", true, "true", [true], true, [true]]).must_equal [true, "true", [true]]
  end

end
