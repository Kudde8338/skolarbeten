require_relative 'spec_helper'

FUNCTION = 'contains'
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

  it 'Använder inte ".contains?"' do
    require_relative RELATIVE_PATH
    Array.any_instance.expects(:contains?).never
    StudentMethods.send(FUNCTION, [1, 2, 3, 4, 5], 1)
  end

  it 'returnerar true till input (["ketchup", "ketchup", "senap", "ketchup"],"ketchup")' do
    StudentMethods.send(FUNCTION, ["ketchup", "ketchup", "senap", "ketchup"],"ketchup").must_equal true
  end

  it 'returnerar false till input ([2,1,0,88,93], 5)' do
    StudentMethods.send(FUNCTION, [2,1,0,88,93], 5).must_equal false
  end

  it 'returnerar true till input ([8, 2, 0, 2, 5, 0, 0, 0], 0)' do
    StudentMethods.send(FUNCTION, [8, 2, 0, 2, 5, 0, 0, 0], 0).must_equal true
  end

  it 'returnerar false till input (["ketchup", "ketchup", "senap", "ketchup"],"Ketchup")' do
    StudentMethods.send(FUNCTION, ["ketchup", "ketchup", "senap", "ketchup"],"Ketchup").must_equal false
  end

end