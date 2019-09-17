class PolyTreeNode
    attr_reader :value, :parent, :children

    def initialize(value)
        @value = value
        @parent = nil
        @children = []
    end

    def parent=(parent_node)
        unless self.parent.nil?
            self.parent.remove_child(self)
        end

        @parent = parent_node
        @parent.children << self unless parent.nil? || parent.children.include?(self)
    end

    def remove_child(child_node)
        if self.children.include?(child_node)
            @children.delete(child_node)
            child_node.parent = nil
        else
            raise "Not a child"
        end
    end

    def add_child(child_node)
        child_node.parent = self
    end

    def bfs(target_value)
        queue = [ self ]

        until queue.empty?
            current_node = queue.shift
            return current_node if target_value == current_node.value
            current_node.children.each do |child_node|
                queue.push(child_node)
            end
        end

        nil
    end

    def dfs(target_value)
        return self if self.value == target_value
        self.children.each do |child_node|
            search_result = child_node.dfs(target_value)
            return search_result unless search_result.nil?
        end
        nil
    end
end