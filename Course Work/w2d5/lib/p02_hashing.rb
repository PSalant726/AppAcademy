class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    inject("") { |accum, elem| accum += elem.hash.abs.to_s}.to_i.hash.abs
  end
end

class String
  def hash
    alpha = ("a".."z").to_a.concat(("A".."Z").to_a)
    hash_string_arr = self.split("").map do |letter|
      alpha.find_index(letter)
    end
    hash_string_arr.unshift(1).hash.abs
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    hash_keys_arr = self.keys.sort.map do |key|
      key.to_s.hash.abs
    end

    hash_vals_arr = self.values.sort.map do |value|
      value.hash
    end

    hash_keys_arr.concat(hash_vals_arr).hash
  end
end


if __FILE__ == $PROGRAM_NAME
  a = [1,2,3,4]
  b = [2,3,4,1]
  c = [1,2,3,4]
  d = "Ruby"
  #
  # p a.hash
  # p b.hash
  # p c.hash
  # p a.hash == c.hash
  # p a.hash != b.hash

  p d.hash.class.superclass
end
