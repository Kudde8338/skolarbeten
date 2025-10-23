def strip(str)
    while (str[0] == "\n" || str[0] == " " || str[0] == "\r" || str[0] == "\t")
        str[0] = ""
    end
    while (str[-1] == "\n" || str[-1] == " " || str[-1] == "\r" || str[-1] == "\t")
        str[-1] = ""
    end
    return str
end

def remove_excess_spaces(str)
  index=0
  while index < str.length 
    if str[index+1] == " " && str[index] == " "
      str[index+1] = ""
    else
      index+=1
    end
  end
  return str
end

def word_count(str)
  if str.length == 0
    return 0
  end
  while (str[0]=="\n" || str[0]== " ") || (str[-1]=="\n" || str[-1]== " ")
    str=strip(str)
  end
  str = remove_excess_spaces(str)
  index=0
  count=1
  while index < str.length
    if str[index]== " "
      count+=1
      index+=1
    else 
      index+=1
    end
  end
  p str
  return count
end

