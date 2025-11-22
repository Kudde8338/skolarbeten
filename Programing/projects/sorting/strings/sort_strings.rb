# Algorithms
require_relative '../algorithms/selection.rb'
require_relative '../algorithms/insertion.rb'
require_relative '../algorithms/quick.rb'
require_relative '../algorithms/bogo.rb'
require_relative '../algorithms/bubble.rb'
require_relative '../algorithms/bucket.rb'

# Encoding
require_relative 'encoding.rb'
require_relative 'decoding.rb'

def bucket_string(array, k=5)
    encoded_array = encode_string_array(array)
    sorted_encoded_array = bucket(encoded_array, k)
    sorted_decoded_array = decode_string_array(sorted_encoded_array)
    return sorted_decoded_array
end    

def bogo_string(array)
    encoded_array = encode_string_array(array)
    sorted_encoded_array = bogo(encoded_array)
    sorted_decoded_array = decode_string_array(sorted_encoded_array)
    return sorted_decoded_array
end

def bubble_string(array)
    encoded_array = encode_string_array(array)
    sorted_encoded_array = bubble(encoded_array)
    sorted_decoded_array = decode_string_array(sorted_encoded_array)
    return sorted_decoded_array
end

def insertion_string(array)
    encoded_array = encode_string_array(array)
    sorted_encoded_array = insertion(encoded_array)
    sorted_decoded_array = decode_string_array(sorted_encoded_array)
    return sorted_decoded_array
end

def quick_string(array)
    encoded_array = encode_string_array(array)
    sorted_encoded_array = quick(encoded_array)
    sorted_decoded_array = decode_string_array(sorted_encoded_array)
    return sorted_decoded_array
end

def selection_string(array)
    encoded_array = encode_string_array(array)
    sorted_encoded_array = selection(encoded_array)
    sorted_decoded_array = decode_string_array(sorted_encoded_array)
    return sorted_decoded_array
end