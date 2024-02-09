pub fn LinkedList(comptime T: type) type {
    return struct {
        const Self = @This();

        pub const Node = struct {
            prev: ?*Node = null,
            next: ?*Node = null,
            data: T,
        };

        first: ?*Node = null,
        last: ?*Node = null,
        len: usize = 0,

        pub fn push(self: *Self, node: *Self.Node) void {
            if (self.len == 0) {
                self.first = node;
            } else {
                const last = self.last.?;
                last.next = node;
                node.prev = last;
            }
            self.last = node;
            self.len += 1;
        }

        pub fn pop(self: *Self) ?*Node {
            if (self.len == 0) return null;
            const last = self.last.?;
            if (self.len == 1) {
                self.first = null;
                self.last = null;
            } else {
                self.last = last.prev;
            }
            self.len -= 1;
            return last;
        }

        pub fn shift(self: *Self) ?*Node {
            if (self.len == 0) return null;
            const first = self.first.?;
            if (self.len == 1) {
                self.first = null;
                self.last = null;
            } else {
                self.first = first.next;
            }
            self.len -= 1;
            return first;
        }

        pub fn unshift(self: *Self, node: *Node) void {
            if (self.len == 0) {
                self.last = node;
            } else {
                const first = self.first.?;
                first.prev = node;
                node.next = first;
            }
            self.first = node;
            self.len += 1;
        }

        pub fn delete(self: *Self, node: *Node) void {
            var curr_node = self.first;
            while (curr_node) |curr_node_d| : (curr_node = curr_node_d.next) {
                if (curr_node_d == node) {
                    if (curr_node_d.prev) |prev_node| {
                        prev_node.next = curr_node_d.next;
                    }
                    if (curr_node_d.next) |next_node| {
                        next_node.prev = curr_node_d.prev;
                    }
                    if (curr_node_d == self.first) {
                        self.first = curr_node_d.next;
                    } else if (curr_node_d == self.last) {
                        self.last = curr_node_d.prev;
                    }
                    self.len -= 1;
                    return;
                }
            }
        }
    };
}
