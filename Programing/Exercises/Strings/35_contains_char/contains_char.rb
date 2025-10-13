def contains_char(string, char)
    i = 0
    while i <= string.length
        if string[i] == char
            return true
        end
        i += 1
    end
    return false
end
