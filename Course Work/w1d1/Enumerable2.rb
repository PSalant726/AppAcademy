class Array
  def my_each(&prc)
    i = 0
    while i < self.length
      prc.call(self[i])
      i += 1
    end
  end

  def my_select(&prc)
    return_array = []
    self.my_each { |idx| return_array << idx if prc.call(idx) == true }
    return_array
  end

  def my_reject(&prc)
    return_array = []
    self.my_each { |idx| return_array << idx unless prc.call(idx) == true }
    return_array
  end

  def my_any?(&prc)
    flag = false
    self.my_each { |idx| flag = true if prc.call(idx) == true }
    flag
  end

  def my_all?(&prc)
    flag = true
    self.my_each { |idx| flag = false if prc.call(idx) != true }
    flag
  end

  def my_flatten
    return_array = []
    self.my_each do |idx|
      if idx.is_a?(Array)
        return_array.concat(idx.my_flatten)
      else
        return_array << idx
      end
    end
    return_array
  end

  def my_zip(*args)
    return_array = Array.new(self.length) { Array.new() }
    self.each_with_index { |el,idx| return_array[idx] << el }
    args.my_each do |arr|
      i = 0
      while i < self.length
        return_array[i] << arr[i]
        i += 1
      end
    end
    return_array
  end

  def my_rotate(rot = 1)
    return_array = self.dup
    rot = rot % return_array.length
    rot.times { return_array.push(return_array.shift) }
    return_array
  end

  def my_join(sep = "")
    string = []
    self.each_with_index do |letter,idx|
      idx == self.length - 1 ? string << letter : string << letter + sep
    end
    string.join("")
  end

  def my_reverse
    return_array = []
    arr = self.dup
    arr.length.times { return_array << arr.pop }
    return_array
  end
end

if __FILE__ == $PROGRAM_NAME
  a = [1,2,3]
  b = [1,2,[3,4],5,[6,7,[8]]]
  c = [4,5,6]
  d = [7,8,9]
  e = [10,11,12]
  f = [13,14,15]
  g = ("a".."d").to_a
  h = ("a".."c").to_a
  puts "my_each"
  p a.my_each { |num| puts num }
  puts "my_select"
  p a.my_select { |num| num > 1 }
  puts "my_reject"
  p a.my_reject { |num| num > 1 }
  puts "my_any?"
  p a.my_any? { |num| num > 4 }
  p a.my_any? { |num| num < 2 }
  puts "my_all?"
  p a.my_all? { |num| num > 2 }
  p a.my_all? { |num| num > 0 }
  puts "my_flatten"
  p b.my_flatten
  puts "my_zip"
  p a.my_zip(c,d)
  p c.my_zip([1,2],[8])
  p [1,2].my_zip(c,d)
  p [1,2].my_zip(c,d,e,f)
  puts "my_rotate"
  p g.my_rotate
  p g.my_rotate(2)
  p g.my_rotate(-3)
  p g.my_rotate(15)
  puts "my_join"
  p g.my_join
  p g.my_join("$")
  puts "my_reverse"
  p h.my_reverse
  p [ 1 ].my_reverse
end
