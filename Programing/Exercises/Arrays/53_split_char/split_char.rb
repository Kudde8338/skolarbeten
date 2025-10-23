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


'''
def split_char("1;2;3;4;5", ";")

    newArray = []
    i = 0
    newString = ""
    string.length=9
    while i < string.length
        if string[i] != char
            newString << string[i]
        else

            newArray << newString
            newString = ""
        end
        i += 1
    end

    return newArray
end
'''