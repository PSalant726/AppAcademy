require 'byebug'

class PolyTreeNode
  attr_reader :parent, :value
  attr_accessor :children

  def initialize(value)
    @value = value
    @parent = nil
    @children = []
  end

  def to_s
    @value
  end

  def add_child(child_node)
    child_node.parent = self
  end

  def remove_child(child)
    child.parent != self ? raise("error") : child.parent = nil
  end

  def parent=(parent_node)
    # debugger
    unless parent_node.nil?
      if @parent.nil?
        @parent = parent_node
        parent_node.children << self unless parent_node.children.include?(self)
      elsif @parent != parent_node
        @parent.children.delete(self)
        @parent = parent_node
        parent_node.children << self unless parent_node.children.include?(self)
      end
    else
      @parent = nil
    end
  end

  def dfs(target_value)
    return self if @value == target_value
    @children.each do |child|
      result = child.dfs(target_value)
      return result unless result.nil?
    end
    nil
  end

  def bfs(target_value)
    queue = [self]
    # debugger
    until queue.empty?
      test_node = queue.shift
      return test_node if test_node.value == target_value
      test_node.children.each { |child| queue << child }
    end
    nil
  end
end

if __FILE__ == $PROGRAM_NAME
  node = PolyTreeNode.new("A")
  node2 = PolyTreeNode.new("B")
  node.bfs(node2)
end
