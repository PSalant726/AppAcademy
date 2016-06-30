def factors(num)
  facs = []
  1.upto(num) { |number| facs << number if num % number == 0 }
  facs
end

def substrings(string)
  arr = string.split("")
  ret_arr = []
  arr.each_with_index do |letter, idx|
    i = idx + 1
    while i <= arr.length
      ret_arr << string[idx...i]
      i += 1
    end
  end
  ret_arr
end

def subwords(word,dictionary)
  words = []
  substrings(word).each do |word|
    if dictionary.include?(word) && !words.include?(word)
      words << word
    end
  end
  words
end

class Array
  def bubble_sort!(&prc)
    prc ||= Proc.new() { |num1, num2| num1 <=> num2 }
    sorted = false
    until sorted
      sorted = true
      each_with_index do |el,idx|
        i = idx + 1
        if i < length && prc.call(el,self[i]) == 1
          sorted = false
          self[idx],self[i] = self[i],self[idx]
        end
      end
    end
    self
  end

  def bubble_sort
    arr = self.dup
    arr.bubble_sort!
  end
end

if __FILE__ == $PROGRAM_NAME
  p substrings("erbearsweatmyajs")
end
