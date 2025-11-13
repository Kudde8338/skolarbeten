$insertion_state = []

def insertion(array, visualize=false)
    sorted = 1
    while sorted < array.length
        i = sorted
        while i > 0
            if array[i] < array[i - 1]
                temp = array[i]
                array[i] = array[i - 1]
                array[i - 1] = temp
                if visualize
                    $insertion_state.push(array.dup)
                end
                i -= 1
            else
                break
            end
        end
        sorted += 1
    end
    return array
end