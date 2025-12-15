
def christmas_tree(height)
  tree = []
  number_of_chars = 0

  i = height
  while i > 0
    number_of_chars += (2*i - 1)
    i -= 1
  end

  group1 = number_of_chars.to_f * (2.0/3)
  group2 = group1 + number_of_chars.to_f * (1.0/6)
  group3 = group2 + number_of_chars.to_f * (1.0/6)

  i = 0
  while i < group1
    tree << "^"
    i+=1
  end

  while i < group2
    tree << "*"
    i+=1
  end

  while i < group3
    tree << "i"
    i+=1
  end

  while tree.length < number_of_chars
    tree << "^"
  end

  while tree.length > number_of_chars
    tree.pop()
  end

  tree = tree.shuffle()
  tree[0] = "*"


  # Sort into 2D array
  tree2D = []
  temparr = []
  chars = 1
  while tree.length > 0
    i = 0
    while i < chars
      temparr << tree[0]
      tree.delete_at(0)
      i += 1
    end
    tree2D << temparr
    chars += 2
  end

  return tree2D

end

p christmas_tree(10)