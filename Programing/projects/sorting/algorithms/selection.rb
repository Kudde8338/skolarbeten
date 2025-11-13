$selection_state = []

def selection(array, visualize=false)
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
        if visualize == true
            $selection_state.push(array.dup)
        end
        j += 1
    end
    return array
end