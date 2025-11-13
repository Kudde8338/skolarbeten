$quick_state = []

def quick(array, start=0, stop=nil, visualize=false)
    if stop == nil
        stop = array.length - 1
    end
    return array if start >= stop

    i = start - 1
    j = start
    pivot = array[stop]
    while j < stop
        if array[j] < pivot
            i += 1
            temp = array[i]
            array[i] = array[j]
            array[j] = temp
            if visualize == true
                $quick_state.push(array.dup)
            end
        end
        j+=1
    end
    temp = array[stop]
    array[stop] = array[i+1]
    array[i+1] = temp
    lower = [start, i]
    larger = [i+2, stop]
    pivot = i+1

    if visualize == true
        $quick_state.push(array.dup)
    end
    quick(array, start, pivot-1, visualize)
    quick(array, pivot+1, stop, visualize)
    return array
end