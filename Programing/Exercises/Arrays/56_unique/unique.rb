def contains(array, value)
    i = 0
    while i < array.length
        if array[i] == value
            return true
        end
        i += 1
    end
    return false
end


def unique(array)

    newArray = []
    i = 0

    while i < array.length
        if contains(newArray, array[i]) == true
            i += 1
        else    
            newArray << array[i]
            i += 1
        end
    end
    return newArray
end



        
    
