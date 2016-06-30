require_relative 'p02_hashing'
require_relative 'p04_linked_list'

class HashMap
  include Enumerable

  attr_reader :count, :store

  def initialize(buckets = 8)
    @store = Array.new(buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    mod = key.hash % num_buckets
    store[mod].include?(key)
  end

  def set(key, val)
    resize! if count >= num_buckets
    mod = key.hash % num_buckets

    if store[mod].include?(key)
      link_to_change = store[mod].select { |link| link.key == key }.first
      link_to_change.val = val
    else
      store[mod].insert(key, val)
    end

    @count += 1
  end

  def get(key)
    mod = key.hash % num_buckets
    store[mod].get(key)
  end

  def delete(key)
    mod = key.hash % num_buckets
    store[mod].remove(key)
    @count -= 1
  end

  def each(&prc)
    store.each do |linkedlist|
      linkedlist.list.each do |link|
        prc.call(link.key, link.val)
      end
    end
  end

  # uncomment when you have Enumerable included
  def to_s
    pairs = inject([]) do |strs, (k, v)|
      strs << "#{k.to_s} => #{v.to_s}"
    end
    "{\n" + pairs.join(",\n") + "\n}"
  end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    new_hash_map = Array.new(num_buckets * 2) { LinkedList.new }
    @store.each do |bucket|
      bucket.each do |link|
        mod = link.key.hash % (num_buckets * 2)
        new_hash_map[mod].insert(link.key, link.val)
      end
    end
    @store = new_hash_map
    # we had "store = new_hash_map"
  end

  def bucket(key)
    # optional but useful; return the bucket corresponding to `key`
  end
end
