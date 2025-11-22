$bubble_state = []

def bubble(array, visualize=false)
    swaps = 1
    while swaps > 0
        swaps = 0
        i = 0
        while i < array.length - 1
            if array[i] > array[i + 1]
                array[i], array[i + 1] = array[i + 1], array[i]
                swaps += 1
                if visualize == true
                    $bubble_state.push(array.dup)
                end
            end
            i += 1
        end
    end
    return array
end