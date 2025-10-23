require_relative 'spec_helper'

FUNCTION = 'is_empty'
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

  it 'returnerar true till input []' do
    StudentMethods.send(FUNCTION, []).must_equal true
  end

  it 'returnerar false till input ["varmkorv", "senap"]' do
    StudentMethods.send(FUNCTION, ["varmkorv", "senap"]).must_equal false
  end

  it 'returnerar false input [nil]' do
    StudentMethods.send(FUNCTION, [nil]).must_equal false
  end
  
  it 'does not use the empty? method' do
    file_content = File.read(PATH)
    refute_match(/\.empty\?/, file_content, "Funktionen #{FUNCTION} får inte använda metoden empty?")
  end

end