const std = @import("std");
const mem = std.mem;

const Bracket = enum {
    Braces,
    Brackets,
    Parentheses,
    fn fromCharOrNull(c: u8) ?Bracket {
        return switch (c) {
            '{', '}' => Bracket.Braces,
            '[', ']' => Bracket.Brackets,
            '(', ')' => Bracket.Parentheses,
            else => null,
        };
    }
};

pub fn isBalanced(allocator: mem.Allocator, s: []const u8) !bool {
    var stack = try std.ArrayList(Bracket).initCapacity(allocator, s.len);
    defer stack.deinit();

    for (s) |c| {
        switch (c) {
            '{', '[', '(' => stack.appendAssumeCapacity(Bracket.fromCharOrNull(c).?),
            '}', ']', ')' => if (stack.popOrNull() != Bracket.fromCharOrNull(c)) return false,
            else => {},
        }
    }

    return stack.items.len == 0;
}
