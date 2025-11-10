$selection_state = []

def selection_V1(array)
    j = 0
    while j < array.length
        i = j
        min = j
        while i < array.length
            if array[i] < array[min]
                min = i
            end
            i += 1
        end
        array.insert(j, array[min])
        array.delete_at(min + 1)
        j += 1
    end
    return array
end

def selection(array)
    j = 0
    while j < array.length
        i = j
        min = j
        while i < array.length
            if array[i] < array[min]
                min = i
            end
            i += 1
        end
        temp = array[j]
        array[j] = array[min]
        array[min] = temp 
        $selection_state.push(array.dup)
        j += 1
    end
    return array
end