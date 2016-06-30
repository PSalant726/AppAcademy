def reverser (&prc)
    string_as_array = prc.call.split(" ")
    reversed_words = []
    string_as_array.each { |word| reversed_words << word.reverse + " " }
    reversed_words.join("").strip
end

def adder (num = 1, &prc)
    prc.call + num
end

def repeater (n = 1, &prc)
    n.times { prc.call }
end