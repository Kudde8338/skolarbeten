def get_min_max_value(array)
    i = 1
    max_value = array[0]
    min_value = array[0]
    while i < array.length
        if array[i] < min_value
            min_value = array[i]
        end
        if array[i] > max_value
            max_value = array[i]
        end
        i += 1
    end 

    return [min_value, max_value]
end

def get_intervals(array, k)
    min_value, max_value = get_min_max_value(array)
    range = max_value - min_value 
    intervals = range / k.to_f
    return intervals
end

def array_one_value(array)
    first = array[0]
    array.each do |value|
        if value != first
            return false
        end
    end
    return true
end

def bucket(array, k=5)
    return array if array.length <= 1 || array_one_value(array)

    intervals = get_intervals(array, k)
    min_value, max_value = get_min_max_value(array)

    buckets = Array.new(k) { [] }
    array.each do |value|
        index = ((value - min_value) / intervals.to_f).floor
        index = k - 1 if index > k - 1
        index = 0 if index < 0
        buckets[index] << value
    end

    sorted = []
    buckets.each do |bucket|
        next if bucket.empty?
        sorted.concat(bucket.length == 1 ? bucket : bucket(bucket, k))
    end
    return sorted
end

p bucket([1,83,3,2,7,28,2,3,36,34])