def split_char(string, char)

    newArray = []
    i = 0
    newString = ""
    
    while i < string.length
        if string[i] != char
            newString << string[i]
        else
            newArray << newString
            newString = ""
        end
        i += 1
    end
    
    if string[i] != char && newString != ""
        newArray << newString
    end

    return newArray
end