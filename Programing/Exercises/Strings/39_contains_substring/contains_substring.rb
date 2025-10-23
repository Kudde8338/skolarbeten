#RubyVM::YJIT.enable

def contains_substring_V1(str, substr)
    index = 0
    while index <= str.length - substr.length && substr.length > 0
        index2 = 0
        newstr = ""
        while index2 < substr.length
            newstr += str[index+index2]
            index2 += 1
        end
        if newstr == substr
            return true
        end
        index += 1
    end
    return false
end


def contains_substring_V2(str, substr)
    index = 0
    while index <= str.length - substr.length && substr.length > 0
        index2 = 0
        cont = true
        while index2 < substr.length && cont == true
            if str[index+index2] == substr[index2]
                cont=true
                index2 += 1
            else
                cont = false
            end
        end
        if cont == true
            return true
        end
        index += 1
    end
    return false
end

def contains_substring(str, substr)
    index = 0
    if substr.length == 0
        return false
    else
        while index <= str.length - substr.length
            index2 = 0
            cont = true
            while index2 < substr.length && cont == true
                if str[index+index2] == substr[index2]
                    cont=true
                    index2 += 1
                else
                    cont = false
                end
            end
            if cont == true
                return true
            end
            index += 1
        end
        return false
    end
end

def contains_substring_builtin(str, substr)
  str.include?(substr)
end

# måste installera: gem install benchmark-ips
require 'benchmark/ips' # Inkludera benchmark bibliotek

# Generera testcases
substr = "needle"
str = "a" * 10000 + substr

# Kör benchmark
Benchmark.ips(15) do |x|
    x.report("V1: "){contains_substring_V1(str, substr)}            # Testar funktionen: contains_substring_V1 med indata: str, substr
    x.report("V2: "){contains_substring_V2(str, substr)}               # Testar funktionen: contains_substring med indata: str, substr
    x.report("V3: "){contains_substring(str, substr)} 
    #x.report("Builtin: "){contains_substring_builtin(str, substr)}  # Testar funktionen: contains_substring_builtin med indata: str, substr
    x.compare!                                                      # Jämnför testdatan
end