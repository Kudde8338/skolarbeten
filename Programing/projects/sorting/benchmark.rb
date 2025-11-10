require_relative 'algorithms/selection.rb'
require_relative 'algorithms/insertion.rb'
require_relative 'algorithms/quick.rb'
require_relative 'algorithms/bogo.rb'

# måste installera: gem install benchmark-ips
require 'benchmark/ips' # Inkludera benchmark bibliotek

# Generera testcases
array = ((1..10_000).to_a +  (1..10_000).to_a).shuffle

# Kör benchmark
Benchmark.ips(15) do |x|
    x.report("Selection: "){selection(array.dup)}
    x.report("Insertion: "){insertion(array.dup)}
    x.report("Quick: "){quick(array.dup)}
    x.report("BUILT IN: "){array.dup.sort}
    x.compare!
end