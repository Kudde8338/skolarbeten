require_relative 'spec_helper'
# NOT UPDATED WITH STUDENTS METHODS DUE TO CONFLICT WITH Array#prepend

FUNCTION = 'prepend'
ARITY = 2
PATH = File.join(FUNCTION+".rb")
RELATIVE_PATH = File.join("..", PATH)

describe FUNCTION do
  
  def self.test_order
    :alpha
  end

  it 'exists' do
    assert File.exist?(PATH), "Du behöver skapa filen #{PATH}"
    require_relative RELATIVE_PATH
  end
  
  it "has a function named #{FUNCTION}" do
    assert (stubba_class.__method_exists__?(FUNCTION.to_sym)), "Du behöver definera funktionen #{FUNCTION} i lib/#{FUNCTION}.rb"
  end
  
  it "takes #{ARITY.humanize} argument#{ARITY > 1 ? "s" : ""}" do
    message = "Funktionen #{FUNCTION} måste ta #{ARITY} argument"
    assert_equal ARITY, method(FUNCTION.to_sym).arity, message
  end

  # it 'Använder inte "+"' do
  #   require_relative RELATIVE_PATH
  #   Array.any_instance.expects(:+).never
  #   send(FUNCTION, ["varmkorv", "senap"], "ketchup").must_equal ["ketchup", "varmkorv", "senap"]
  # end

  it 'returns ["ketchup", "varmkorv", "senap"] to input (["varmkorv", "senap"], "ketchup")' do
    send(FUNCTION, ["varmkorv", "senap"], "ketchup").must_equal ["ketchup", "varmkorv", "senap"]
  end

  it 'returns [7,2,5,-8] to input ([2,5,-8], 7)' do
    send(FUNCTION, [2,5,-8], 7).must_equal [7,2,5,-8]
  end

  it 'returns [nil, 2] to input ([2], nil)' do
    send(FUNCTION, [2], nil).must_equal [nil,2]
  end

end