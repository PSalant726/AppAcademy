class MyStack
  def initialize
    @store = []
  end

  def pop
    @store.pop
  end

  def push
    @store.push
  end

  def peek
    @store.last
  end

  def size
    @store.size
  end

  def empty?
    @store.empty
  end
end

class MyQueue
  def initialize
    @store = []
  end

  def enqueue(item)
    @store.push(item)
  end

  def dequeue
    @store.shift
  end

  def peek
    @store.first
  end

  def size
    @store.size
  end

  def empty?
    @store.size == 0
  end
end

class StackQueue < MyQueue

  def initialize
    super
    @arr1 = MyQueue.new
    @arr2 = MyQueue.new
  end

  def dequeue
    (@arr1.size - 1).times { @arr2.queue(@arr1.dequeue) }
    item = @arr1.dequeue
    @arr2.size.times { @arr1.queue(@arr2.dequeue) }
    item
  end

  def enqueue(item)
    @arr1.enqueue(item)
  end

  def size
    @arr1.size
  end

  def empty?
    @arr1.empty?
  end
end

if __FILE__ == $PROGRAM_NAME
  stackqueue = StackQueue.new
  p stackqueue.enqueue(1)
  p stackqueue.dequeue
  p stackqueue.size
  p stackqueue.empty?
end
