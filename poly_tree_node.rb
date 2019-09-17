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
        @parent.add_child(self) unless parent.nil? || parent.children.include?(self)
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
end