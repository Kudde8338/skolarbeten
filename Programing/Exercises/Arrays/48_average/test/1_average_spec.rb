require_relative 'spec_helper'

FUNCTION = 'average'
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

  it 'Använder inte ".sum"' do
    require_relative RELATIVE_PATH
    Array.any_instance.expects(:sum).never
    StudentMethods.send(FUNCTION, [1, 2, 3, 4, 5])
  end

  it 'returnerar 3.0 till input [1, 2, 3, 4, 5]' do
    StudentMethods.send(FUNCTION, [1, 2, 3, 4, 5]).must_equal 3.0
  end

  it 'returnerar 1337.0 till input [1337, 1337, 1337]' do
    StudentMethods.send(FUNCTION, [1337, 1337, 1337]).must_equal 1337.0
  end

  it 'returnerar fungerande avrundat medelvärde till input [123, 87, -46]' do
    StudentMethods.send(FUNCTION, [123, 87, -46]).must_be_within_delta 54.67 , 0.01
  end

end
