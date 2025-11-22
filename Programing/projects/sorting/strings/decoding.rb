def decode_string(encoded)
    string = encoded.to_s
    i = 0
    new_string = ""
    while i < string.length
        num = (string[i + 1] + string[i + 2]).to_i
        char = "¿¿¿" + num.to_s + "¿¿¿"

        ### GENERAL CASES ###

        ## Numbers
        if string[i].to_i == 1
            offset = 38
            char = (num + offset).ord
        end

        ## LETTERS
        if string[i].to_i == 2
            offset = num >= 39 ? 58 : 55
            char = (num + offset).ord
        end

        ## SPECIAL CHARACTERS
        if string[i].to_i == 3
            offset = 22
            offset = 32 if num >= 26
            offset = 58 if num >= 33
            offset = 84 if num >= 39 
            char = (num + offset).ord
        end

        ### SPECIAL CASES ###

        ## LETTERS ##

        # lowercase å
        if (string[i].to_i + num) == 265
            char = 229.ord
        end

        # uppercase Å
        if (string[i].to_i + num) == 236
            char = 197.ord
        end

        # lowercase ä
        if (string[i].to_i + num) == 266
            char = 228.ord
        end

        # uppercase Ä
        if (string[i].to_i + num) == 237
            char = 196.ord
        end

        # lowercase ö
        if (string[i].to_i + num) == 267
            char = 246.ord
        end

        # uppercase Ö
        if (string[i].to_i + num) == 238
            char = 214.ord
        end

        ## SPECIAL CHARACTERS ##

        # ,
        if (string[i].to_i + num) == 120
            char = 44.ord
        end

        # .
        if (string[i].to_i + num) == 121
            char = 46.ord
        end

        i+=3
        new_string << char
    end
    return new_string
end

def decode_string_array(array)
    i = 0
    new_array = []
    while i < array.length
        new_array << decode_string(array[i])
        i+=1
    end
    return new_array
end