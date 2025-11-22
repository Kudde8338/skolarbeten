def encode_string(string)
    i = 0
    array = []
    while i < string.length
        char = ""

        ### GENERAL CASES ###
        ## Numbers ##
        if string[i].ord >= 48 && string[i].ord <= 57
            char = "1" + (string[i].ord - 38).to_s
        end

        ## LETTERS ##
        if string[i].ord >= 65 && string[i].ord <= 90
            char = "2" + (string[i].ord - 55).to_s
        end

        if string[i].ord >= 97 && string[i].ord <= 122
            char = "2" + (string[i].ord - 58).to_s
        end

        ## SPECIAL CHARACTERS ##
        if string[i].ord >= 20 && string[i].ord <= 47
            char = "3" + (string[i].ord - 22).to_s
        end

        if string[i].ord >= 58 && string[i].ord <= 64
            char = "3" + (string[i].ord - 32).to_s
        end

        if string[i].ord >= 91 && string[i].ord <= 96
            char = "3" + (string[i].ord - 58).to_s
        end

        if string[i].ord >= 123 && string[i].ord <= 126
            char = "3" + (string[i].ord - 84).to_s
        end


        ### SPECIAL CASES ###

        ## LETTERS ##

        # lowercase  å
        if string[i].ord == 229
            char = "265"
        end

        # uppercase Å
        if string[i].ord == 197
            char = "236"
        end

        # lowercase ä
        if string[i].ord == 228
            char = "266"
        end

        # uppercase Ä
        if string[i].ord == 196
            char = "237"
        end

        # lowercase ö
        if string[i].ord == 246
            char = "267"
        end

        # uppercase Ö
        if string[i].ord == 214
            char = "238"
        end

        ## SPECIAL CHARACTERS ##
        # ,
        if string[i].ord == 44
            char = "120"
        end

        # .
        if string[i].ord == 46
            char = "121"
        end

        array << char
        i+=1
    end

    i = 0
    encoded_string = ""
    while i < array.length
        encoded_string += array[i]
        i+=1
    end

    return encoded_string.to_i
end

def encode_string_array(array)
    i = 0
    new_array = []
    while i < array.length
        new_array << encode_string(array[i])
        i+=1
    end
    return new_array
end
