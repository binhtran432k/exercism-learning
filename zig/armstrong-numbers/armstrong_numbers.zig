const std = @import("std");

pub fn isArmstrongNumber(num: u128) bool {
    if (num < 0) {
        unreachable;
    }
    if (num == 0) {
        return true;
    }
    const n: usize = @intFromFloat(@ceil(@log10(@as(f64, @floatFromInt(num)))));
    var walk_num = num;
    var sum: u128 = 0;
    for (0..n) |_| {
        const digit = @rem(walk_num, 10);
        sum += std.math.pow(u128, digit, n);
        walk_num = @divTrunc(walk_num, 10);
    }
    return sum == num;
}
