const std = @import("std");
const fmt = std.fmt;
const mem = std.mem;

pub fn recite(allocator: mem.Allocator, words: []const []const u8) (fmt.AllocPrintError || mem.Allocator.Error)![][]u8 {
    var lines = try allocator.alloc([]u8, words.len);

    if (words.len > 1) {
        for (words[0 .. words.len - 1], words[1..], 0..) |word, next_word, i| {
            lines[i] = try fmt.allocPrint(allocator, "For want of a {s} the {s} was lost.\n", .{ word, next_word });
        }
    }
    if (words.len > 0) {
        lines[lines.len - 1] = try fmt.allocPrint(allocator, "And all for the want of a {s}.\n", .{words[0]});
    }

    return lines;
}
