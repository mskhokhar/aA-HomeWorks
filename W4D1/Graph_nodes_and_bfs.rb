class GraphNode
    attr_accessor :value, :neighbors
    def initialize(value)
        @value = value
        @neighbors =[]
    end

end

def bfs(starting_node, target_value)
    visited_nodes = []
    queue = [starting_node]
    until queue.empty?
        ele =queue.shift
        break if visited_nodes.include?(ele)
        visited_nodes << ele
        return ele if ele.value == target_value
        ele.neighbors.each { |child| queue << child }
    end
    nil
end