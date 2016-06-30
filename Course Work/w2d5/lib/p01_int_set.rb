class MaxIntSet
  attr_accessor :store

  def initialize(max)
    @store = Array.new(max, false)
  end

  def insert(num)
    validate!(num)
    store[num] = true
  end

  def remove(num)
    validate!(num)
    store[num] = false
  end

  def include?(num)
    validate!(num)
    store[num] == true
  end

  private

  def is_valid?(num)
    num.is_a?(Fixnum) && (0..@store.size).include?(num)
  end

  def validate!(num)
    raise "Out of bounds" unless is_valid?(num)
  end
end


class IntSet

  attr_accessor :store
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    mod = num % store.size
    store[mod] << num unless include?(num)
  end

  def remove(num)
    mod = num % store.size
    store[mod].delete(num) if store[mod].include?(num)
  end

  def include?(num)
    mod = num % store.size
    store[mod].each { |element| return true if element == num }
    false
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_accessor :store, :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(el)
    resize! if count >= num_buckets
    mod = el % @store.size
    store[mod].push(el) unless store[mod].include?(el)
    @count += 1

  end

  def remove(el)
    mod = el % store.size
    store[mod].delete(el) if store[mod].include?(el)
  end

  def include?(el)
    mod = el % store.size
    store[mod].each { |element| return true if element == el }
    false
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end

  def resize!
    newintset = Array.new(@store.size * 2) { Array.new() }
    store.each do |bucket|
      bucket.each do |elem|
        mod = elem % (@store.size * 2)
        newintset[mod].push(elem)
      end
    end
    self.store = newintset
  end

end
