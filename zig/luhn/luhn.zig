const std = @import("std");

pub fn isValid(s: []const u8) bool {
    var reversed_iter = std.mem.reverseIterator(s);
    var sum: u32 = 0;
    var digit_i: usize = 0;
    while (reversed_iter.next()) |c| {
        const mul_factor: u2 = if (@rem(digit_i, 2) != 0) 2 else 1;
        sum += switch (c) {
            '0'...'9' => digit: {
                const digit = mul_factor * (c - '0');
                break :digit if (digit > 9) digit - 9 else digit;
            },
            ' ' => continue,
            else => return false,
        };
        digit_i += 1;
    }

    if (digit_i <= 1)
        return false;

    return @rem(sum, 10) == 0;
}
