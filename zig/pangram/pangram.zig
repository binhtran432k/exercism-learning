const std = @import("std");

pub fn isPangram(str: []const u8) bool {
    var letters = std.bit_set.IntegerBitSet(26).initFull();
    for (str) |c| {
        if (std.ascii.isAlphabetic(c)) {
            letters.unset(std.ascii.toLower(c) - 'a');
        }
    }
    return letters.count() == 0;
}
