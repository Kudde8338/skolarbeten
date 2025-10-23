def strip_V1(string)
    i = 0
    newstring = ""
    while string[0] == "\n" || string[0] == " " || string[0] == "\r" || string[0] == "\t"
        string[0] = ""
    end
    while i < string.length - 1
        newstring << string[i]
        i += 1
    end
    if string[-1] == "\n" || string[-1] == " " || string[-1] == "\r" || string[-1] == "\t" 
        return newstring
    else
        newstring = newstring + string[-1]
    end
    return newstring
end

def strip(str)
    while (str[0] == "\n" || str[0] == " " || str[0] == "\r" || str[0] == "\t")
        str[0] = ""
    end
    while (str[-1] == "\n" || str[-1] == " " || str[-1] == "\r" || str[-1] == "\t")
        str[-1] = ""
    end
    return str
end



# måste installera: gem install benchmark-ips
require 'benchmark/ips' # Inkludera benchmark bibliotek

# Generera testcases
str = " hej\n"

# Kör benchmark
Benchmark.ips(15) do |x|
    x.report("V1: "){strip_V1(str)}            # Testar funktionen: contains_substring_V1 med indata: str, substr
    x.report("V2: "){strip(str)}               # Testar funktionen: contains_substring med indata: str, substr
    x.compare!                                         # Jämnför testdatan
end