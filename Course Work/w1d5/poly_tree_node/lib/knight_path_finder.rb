require './00_tree_node.rb'

class KnightPathFinder
  DELTAS = [
    [1, 2],
    [1, -2],
    [2, 1],
    [2, -1],
    [-2, 1],
    [-2, -1],
    [-1, 2],
    [-1, -2]
  ]

  attr_reader :start_pos, :visited_positions

  def initialize(start_pos)
    @start_pos = PolyTreeNode.new(start_pos)
    @visited_positions = [start_pos]
  end

  def self.valid_moves(pos)
    sums = []
    DELTAS.each do |delta|
      pos_end = []
      pos_end << pos[0] + delta[0]
      pos_end << pos[1] + delta[1]
      sums << pos_end
    end
    sums.select do |sum|
      sum[0].between?(0,7) && sum[1].between?(0,7)
    end
  end

  def new_move_positions(pos)
    new_positions = KnightPathFinder.valid_moves(pos).reject do |move|
      @visited_positions.include?(move)
    end
    @visited_positions << new_positions
    new_positions
  end

  def build_move_tree(pos_end)
    start_node = PolyTreeNode.new(start_pos)
    node_end = PolyTreeNode.new(pos_end)
    moves_queue = [start_pos]
    nodes_queue = [start_node]
    current_pos = start_pos.value
    current_node = start_node
    until moves_queue.include?(pos_end)
      next_moves = new_move_positions(current_pos)
      moves_queue.concat(next_moves)
      next_move_nodes = []
      next_moves.each do |move|
        node = PolyTreeNode.new(move)
        node.parent = current_node
        nodes_queue << node
      end
      current_node = nodes_queue.index(current_node) + 1
      current_pos = moves_queue.index(current_pos) + 1
    end
    nodes_queue
  end

end

if __FILE__ == $PROGRAM_NAME
  knight = KnightPathFinder.new([0,0])
  p knight.build_move_tree([0,4])

end
