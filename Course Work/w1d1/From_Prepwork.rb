def factors(num)
  return_array = []
  1.upto(num) { |i| return_array << i if num % i == 0 }
  return_array
end

def substrings(string)
  i=0
  j=1
  new_array=[]
  while i < string.length
    while i + j <= string.length
      new_array << string[i,j]
      j+=1
    end
    j = 1
    i += 1
  end
  new_array
end

def subwords(word,dictionary)
  new_array = []
  substrings(word).each do |subword|
    new_array << subword if dictionary.include?(subword)
  end
  new_array
end

class Array
  def bubble_sort!()
    less_than = false
    until less_than
      less_than = true
      0.upto(self.length - 2) do |i|
        if self[i] > self[i + 1]
          less_than = false
          self[i],self[i + 1] = self[i + 1],self[i]
        end
      end
    end
    self
  end

  def bubble_sort(&prc)
    new_array=self.dup
    flag = false
    until flag
      flag = true
      0.upto(new_array.length - 2) do |i|
        if prc.call(new_array[i],new_array[i+1])==1
          flag = false
          new_array[i],new_array[i + 1] = new_array[i + 1],new_array[i]
        end
      end
    end
    new_array
  end


end

if __FILE__ == $PROGRAM_NAME
  p subwords("cat",["a","at","cat"])

end
