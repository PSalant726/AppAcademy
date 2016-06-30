class Link
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end
end




class LinkedList
  include Enumerable

  attr_accessor :list, :prev, :next, :head, :tail

  def initialize
    @list = []
    @head = nil
    @tail = nil
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    list.first
  end

  def last
    list.last
  end

  def empty?
    list.empty?
  end

  def get(key)
    links = list.select { |link| link.key == key }
    if links.empty?
      return nil
    else
      links.first.val
    end
  end

  def include?(key)
    list.any? { |link| link.key == key }
  end

  def insert(key, val)
    newlink = Link.new(key, val)
    last.next = newlink unless last.nil?
    newlink.prev = last
    list.push(newlink)
    @head = newlink if list.empty?
    @tail = newlink
  end

  def remove(key)
    link_with_key = list.select { |link| link.key == key }.first

    list.delete(link_with_key)

    unless link_with_key.prev.nil?
      link_with_key.prev.next = link_with_key.next
    end

    unless link_with_key.next.nil?
      link_with_key.next.prev = link_with_key.prev
    end

    @head = link_with_key.next if link_with_key.prev.nil?
    @tail = link_with_key.prev if link_with_key.next.nil?

    link_with_key.prev = nil
    link_with_key.next = nil

  end

  def each(&prc)
    i = 0
    while i < list.size
      prc.call(list[i])
      i += 1
    end
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
