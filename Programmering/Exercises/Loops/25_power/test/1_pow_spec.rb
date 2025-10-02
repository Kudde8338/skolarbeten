require_relative 'spec_helper'

FUNCTION = 'power'
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

  it 'returns 1 if second input is zero' do
    power(2,0).must_equal 1
    power(3,0).must_equal 1
    power(4,0).must_equal 1
    power(5,0).must_equal 1
    power(6,0).must_equal 1
    power(7,0).must_equal 1
    power(8,0).must_equal 1
    power(9,0).must_equal 1
    power(1337,0).must_equal 1
    power(2096,0).must_equal 1
  end

  it 'returns 1 if first input is 1' do
    power(1,2).must_equal 1
    power(1,3).must_equal 1
    power(1,4).must_equal 1
    power(1,5).must_equal 1
    power(1,6).must_equal 1
    power(1,7).must_equal 1
    power(1,8).must_equal 1
    power(1,9).must_equal 1
    power(1,1337).must_equal 1
    power(1,2096).must_equal 1
  end

  it 'returns first input if second input is 1' do
    power(2,1).must_equal 2
    power(3,1).must_equal 3
    power(4,1).must_equal 4
    power(5,1).must_equal 5
    power(6,1).must_equal 6
    power(7,1).must_equal 7
    power(8,1).must_equal 8
    power(9,1).must_equal 9
    power(1337,1).must_equal 1337
    power(2096,1).must_equal 2096
  end

  it 'returns 4 if first input is 2 and second input is 2' do
    power(2,2).must_equal 4
  end

  it 'returns 6 if first input is 2 and second input is 3' do
    power(2,3).must_equal 8
  end

  it 'returns 27 if first input is 3 and second input is 3' do
    power(3,3).must_equal 27
  end

  it 'works with numerous inputs' do
    power(2,2).must_equal 2**2
    power(3,4).must_equal 3**4
    power(4,5).must_equal 4**5
    power(5,6).must_equal 5**6
    power(6,7).must_equal 6**7
    power(7,8).must_equal 7**8
    power(8,9).must_equal 8**9
    power(9,10).must_equal 9**10
    power(1337,1337).must_equal 1337**1337
    power(2096,4098).must_equal 2096**4098
  end

  it 'works with random inputs' do
    10.times do
      number = rand(1..10_000)
      exponent = rand(1..1000)
      power(number, exponent).must_equal number ** exponent
    end
  end

  it 'does not use the * operator' do
    require_relative RELATIVE_PATH
    Integer.any_instance.expects(:*).never
    power(13,37)
  end

  it 'does not use the ** operator' do
    require_relative RELATIVE_PATH
    Integer.any_instance.expects(:**).never
    power(13,37)
  end
end