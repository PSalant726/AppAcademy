require_relative 'p02_hashing'

class HashSet
  attr_accessor :count, :store

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    resize! if count >= store.size
    mod = key.hash % store.size
    store[mod] << key
    @count += 1
  end

  def include?(key)
    mod = key.hash % store.size
    store[mod].include?(key)
  end

  def remove(key)
    mod = key.hash % store.size
    store[mod].delete(key)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end

  def resize!
    new_hash_set = Array.new(@store.size * 2) { Array.new() }
    store.each do |bucket|
      bucket.each do |elem|
        mod = elem.hash % (@store.size * 2)
        new_hash_set[mod].push(elem)
      end
    end
    self.store = new_hash_set
  end
end
