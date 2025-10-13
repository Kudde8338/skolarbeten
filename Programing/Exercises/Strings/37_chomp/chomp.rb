def chomp(string)

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
