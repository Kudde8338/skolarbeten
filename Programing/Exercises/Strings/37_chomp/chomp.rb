def chomp_V1(string)
    i = 0
    newstring = ""
    while i < string.length - 1
        newstring << string[i]
        i += 1
    end
    if string[-1] == "\n" || string[-1] == " "
        return newstring
    else
        newstring = newstring + string[-1]
    end
    return newstring
end

def chomp(str)
    while (str[-1] == "\n" || str[-1] == " ")
        str[-1] = ""
    end
    return str
end

# måste installera: gem install benchmark-ips
require 'benchmark/ips' # Inkludera benchmark bibliotek

# Generera testcases
strs = ["HellO", "hello", "HellO\n", "hello\n", "HellO\nWorld", "\nhello\n"]

# Kör benchmark
Benchmark.ips(15) do |x|
    x.report("V1: "){chomp_V1(strs.sample)}            # Testar funktionen: contains_substring_V1 med indata: str, substr
    x.report("V2: "){chomp(strs.sample)}               # Testar funktionen: contains_substring med indata: str, substr
    x.compare!                                         # Jämnför testdatan
end