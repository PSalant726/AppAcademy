class LRUCache
  attr_reader :cache, :size

  def initialize(size)
    @cache = []
    @size = size
  end

  def count
    # returns number of elements currently in cache
    cache.length
  end

  def add(el)
    # adds element to cache according to LRU principle
    cache.delete(el) if cache.include?(el)
    cache.shift if cache.count == size
    cache.push(el)
  end

  def show
    # shows the items in the cache, with the LRU item first
    p cache
  end

  private
  # helper methods go here!
end

if __FILE__ == $PROGRAM_NAME
  c = LRUCache.new(5)
  c.add(1)
  c.add(2)
  c.show
  puts c.count
  c.add("three")
  c.add(:four)
  c.add("5")
  puts c.count
  c.show
  c.add(:six)
  c.show
  c.add("three")
  c.show
end
