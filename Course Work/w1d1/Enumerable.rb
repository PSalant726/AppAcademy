class Array
  def my_each(&prc)
    i = 0
    while i < self.length
      prc.call(self[i])
      i += 1
    end
    self
  end

  def my_select(&prc)
    new_array = []
    self.my_each do |val|
      new_array << val if prc.call(val)==true
    end
    new_array
  end

  def my_reject(&prc)
    new_array = []
    self.my_each do |val|
      new_array << val if prc.call(val)==false
    end
    new_array
  end

  def my_any?(&prc)
    is_true=false
    self.my_each do |val|
      is_true=true if prc.call(val)
    end
    is_true
  end

  def my_all?(&prc)
    is_true = true
    self.my_each do |val|
      is_true = false unless prc.call(val)
    end
    is_true
  end

  def my_flatten
    new_array = []
    self.my_each do |val|
      if !val.is_a?(Array)
        new_array << val
      else
        new_array.concat(val.my_flatten)
      end
    end
    new_array
  end

  def my_zip(*arrays)
    new_array=[]
    i=0
    self.my_each do |val|
      mini_array = [val]
      arrays.my_each do |val2|
        if !val2.nil?
          mini_array << val2[i]
        else
          mini_array << nil
        end
      end
      i += 1
      new_array << mini_array
    end
    new_array
  end

  def my_rotate(rot = 1)
    new_array = self.dup
    (rot % new_array.length).times { new_array.push(new_array.shift) }
    new_array
  end

  def my_join(sep="")
    return_string = ""
    i=0
    self.my_each do |val|
      i == (self.length-1) ? return_string << val : return_string << val + sep
      i+=1
    end
    return_string
  end

  def my_reverse
    return_array = []
    self.my_each do |val|
      return_array.unshift(val)
    end
    return_array
  end

end

if __FILE__ == $PROGRAM_NAME
  test_array = ["a", "b", "c", "d"]
  p test_array.my_reverse
  p test_array
end
