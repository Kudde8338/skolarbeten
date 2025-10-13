require_relative 'spec_helper'
require 'stringio'

def capture_stdout
  old_stdout = $stdout
  $stdout = StringIO.new
  yield
  $stdout.string
ensure
  $stdout = old_stdout
end

FUNCTION = 'countdown'
ARITY = 1
PATH = File.join(FUNCTION+".rb")
RELATIVE_PATH = File.join("..", PATH)
describe FUNCTION do


  before do
    # Override `sleep` in this test to do nothing
    def sleep(_duration); end
  end


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

  it 'Skriver ut 1 & Take-off! när input är 1' do
    output = capture_stdout { countdown(1) }
    assert_equal "1\nTake-off!\n", output, "Funktionen borde skriva ut 1, och Take-off! när input är 1"
  end

  it 'Skriver ut 2, 1 och Take-off! när input är 2' do
    output = capture_stdout { countdown(2) }
    assert_equal "2\n1\nTake-off!\n", output, "Funktionen borde skriva ut '1' och '2' när input är 2"
  end

  it 'Räknar ner från 10 när input är 10 ' do
    output = capture_stdout { countdown(10) }
    expected_output = ([10,9,8,7,6,5,4,3,2,1].map { |n| "#{n}\n" }.join) + "Take-off!\n"
    assert_equal expected_output, output, "Funktionen borde räkna ner från 10"
  end



end
