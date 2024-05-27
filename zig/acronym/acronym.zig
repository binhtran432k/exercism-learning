const std = @import("std");
const mem = std.mem;

pub fn abbreviate(allocator: mem.Allocator, words: []const u8) mem.Allocator.Error![]u8 {
    var acronym = std.ArrayList(u8).init(allocator);
    defer acronym.deinit();
    var frist_char_flag = true;
    for (words) |c| {
        if (frist_char_flag and std.ascii.isAlphabetic(c)) {
            try acronym.append(std.ascii.toUpper(c));
            frist_char_flag = false;
        } else if (c == ' ' or c == '-') {
            frist_char_flag = true;
        }
    }
    return acronym.toOwnedSlice();
}
