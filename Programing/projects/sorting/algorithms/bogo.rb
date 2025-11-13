$bogo_state = []

def bogo(array, visualize=false)
    sorted = false
    until sorted
        array = array.shuffle
        if visualize
            $bogo_state.push(array.dup)
        end
        i = 0
        sorted = true
        while i < array.length - 1
            if array[i] >= array[i+1]
                sorted = false
            end
            i += 1
        end
    end
    return array
end