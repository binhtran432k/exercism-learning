const std = @import("std");
const ascii = std.ascii;
const mem = std.mem;

/// Returns the counts of the words in `s`.
/// Caller owns the returned memory.
pub fn countWords(allocator: mem.Allocator, s: []const u8) !std.StringHashMap(u32) {
    var word_count_map = std.StringHashMap(u32).init(allocator);
    errdefer freeKeysAndDeinit(&word_count_map);
    var word_builder = std.ArrayList(u8).init(allocator);
    defer word_builder.deinit();

    for (s, 0..) |c, i| {
        const end_word_flag = switch (c) {
            ' ', '\n', '\t', '\r', ',', '.', '?', '!', '&', '@', '$', '%', '^', ':', '"' => true,
            else => blk: {
                try word_builder.append(ascii.toLower(c));
                break :blk if (i == s.len - 1) true else false;
            },
        };
        if (end_word_flag and word_builder.items.len > 0) {
            const word_raw = word_builder.items;
            const start_with_apos = word_raw[0] == '\'';
            const end_with_apos = word_raw[word_raw.len - 1] == '\'';
            const begin: usize = if (start_with_apos) 1 else 0;
            const end: usize = if (end_with_apos) word_raw.len - 1 else word_raw.len;

            if (begin >= end) continue;

            const word = word_raw[begin..end];
            if (word_count_map.get(word)) |curr_count| {
                try word_count_map.put(word, curr_count + 1);
            } else {
                const copied_word = try allocator.dupe(u8, word);
                errdefer allocator.free(copied_word);
                try word_count_map.put(copied_word, 1);
            }
            word_builder.clearAndFree();
        }
    }

    return word_count_map;
}

fn freeKeysAndDeinit(self: *std.StringHashMap(u32)) void {
    var iter = self.keyIterator();
    while (iter.next()) |key_ptr| {
        self.allocator.free(key_ptr.*);
    }
    self.deinit();
}
