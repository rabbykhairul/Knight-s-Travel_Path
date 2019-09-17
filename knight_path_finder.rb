require_relative "./poly_tree_node.rb"

class KnightPathFinder
    def initialize(start_position)
        @position = start_position
        @root_node = PolyTreeNode.new(@position)
        @considered_positions = [ @position ]
        build_move_tree
    end

    def self.valid_moves(pos)
        move_directions = [
            [ 2, 1 ],
            [ 2, -1 ],
            [ -2, 1 ],
            [ -2, -1 ],
            [ 1, 2 ],
            [ -1, 2 ],
            [ 1, -2 ],
            [ -1, -2 ]
        ]

        possible_moves = []
        move_directions.each do |direction|
            move_row, move_col = pos[0] + direction[0], pos[1] + direction[1]
            possible_moves << [ move_row, move_col ] if within_range?([ move_row, move_col ])
        end
        
        possible_moves
    end

    def self.within_range?(pos)
        row, col = pos
        row.between?(0,7) && col.between?(0,7)
    end

    def new_move_positions(pos)
        all_possible_moves = KnightPathFinder.valid_moves(pos)   
        new_moves = all_possible_moves.select { |move_pos| !@considered_positions.include?(move_pos) }
        @considered_positions += new_moves
        new_moves
    end

    def build_move_tree
        queue = [ @root_node ]

        until queue.empty?
            current_node = queue.shift
            current_position = current_node.value
            moves_from_current_position = new_move_positions(current_position)

            moves_from_current_position.each do |move_pos|
                child_node = PolyTreeNode.new(move_pos)
                child_node.parent = current_node
                queue << child_node
            end
        end
    end

    def find_path(end_pos)
        end_pos_node = @root_node.dfs(end_pos)
        trace_path_back(end_pos_node)
    end

    def trace_path_back(end_pos_node)
        end_pos = end_pos_node.value

        path_arr = [ end_pos ]
        parent_node = end_pos_node.parent

        until parent_node.nil?
            path_arr << parent_node.value
            parent_node = parent_node.parent
        end

        path_arr.reverse
    end
end
