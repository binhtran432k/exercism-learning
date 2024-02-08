const std = @import("std");
const mem = std.mem;
const ascii = std.ascii;

/// Returns the set of strings in `candidates` that are anagrams of `word`.
/// Caller owns the returned memory.
pub fn detectAnagrams(
    allocator: mem.Allocator,
    word: []const u8,
    candidates: []const []const u8,
) !std.BufSet {
    var anagrams = std.BufSet.init(allocator);
    errdefer anagrams.deinit();

    var encoded_word = try allocator.alloc(u8, word.len);
    defer allocator.free(encoded_word);
    _ = encode(encoded_word, word);

    var encoded_cand: []u8 = try allocator.alloc(u8, word.len);
    defer allocator.free(encoded_cand);

    for (candidates) |c| {
        if (word.len != c.len) continue;
        if (ascii.eqlIgnoreCase(word, c)) continue;
        _ = encode(encoded_cand, c);
        if (mem.eql(u8, encoded_word, encoded_cand)) {
            try anagrams.insert(c);
        }
    }
    return anagrams;
}

fn encode(dest: []u8, source: []const u8) []u8 {
    _ = ascii.lowerString(dest, source);
    mem.sort(u8, dest, {}, std.sort.asc(u8));
    return dest;
}
