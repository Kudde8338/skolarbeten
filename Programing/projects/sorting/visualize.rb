require_relative 'algorithms/selection.rb'
require_relative 'algorithms/insertion.rb'
require_relative 'algorithms/quick.rb'
require_relative 'algorithms/bogo.rb'

def visualize(array_history)
  array_history.each_with_index do |arr, step|
    puts "Step #{step}:"
    arr.each do |value|
      puts "|" + "#" * value  # skapa ett "bar chart" med #
    end
    puts "\n"
    sleep(0.2)  # paus så man kan se förändringen
  end
end


array = (1..15).to_a.shuffle
selection(array.dup)
p "Selection Done"
insertion(array.dup)
p "Insertion Done"
quick(array.dup)
p "Quick Done"
bogo(array.dup)
p "Bogo Done"
visualize($selection_state)
puts "Press Enter to continue..."
gets
visualize($insertion_state)
puts "Press Enter to continue..."
gets
visualize($quick_state)
puts "Press Enter to continue..."
gets
visualize($bogo_state)
