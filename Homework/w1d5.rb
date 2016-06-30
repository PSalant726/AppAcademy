# Exercise 1
class Stack
  def initialize
    # create ivar to store stack here!
    @stack = []
  end

  def add(el)
    # adds an element to the stack
    stack << el
  end

  def remove
    # removes one element from the stack
    stack.pop
  end

  def show
    # return a copy of the stack
    stack
  end

  private
  attr_reader :stack
end

# Exercise 2
class Queue
  def initialize
    @queue = []
  end

  def enqueue(el)
    queue << el
  end

  def dequeue
    queue.shift
  end

  def show
    queue
  end

  private
  attr_reader :queue
end

# Exercise 3
class Map
  def initialize
    @map = []
  end

  def assign(key, val)
    key_present = false
    map.each { |pair| key_present = true if pair[0] == key }
    if key_present
      map.each { |pair| pair[1] = val if pair[0] == key }
    else
      map << [key, val]
    end
  end

  def lookup(key)
    map.each { |pair| return pair[1] if pair[0] == key }
  end

  def show
    map
  end

  private
  attr_reader :map
end

if __FILE__ == $PROGRAM_NAME
  puts "Stack Tests"
  stack = Stack.new
  p stack.show
  stack.add(1)
  p stack.show
  stack.add(2)
  p stack.show
  stack.add(3)
  p stack.show
  stack.remove
  p stack.show
  stack.remove
  p stack.show
  stack.remove
  p stack.show

  puts "\nQueue Tests"
  queue = Queue.new
  p queue.show
  queue.enqueue(1)
  p queue.show
  queue.enqueue(2)
  p queue.show
  queue.enqueue(3)
  p queue.show
  queue.dequeue
  p queue.show
  queue.dequeue
  p queue.show
  queue.dequeue
  p queue.show

  puts "\nMap Tests"
  map = Map.new()
  p map.show
  map.assign(1, "Hate")
  p map.show
  map.assign(2, "Me")
  p map.show
  map.assign(1, "Love")
  p map.show
  p map.lookup(2)
end
