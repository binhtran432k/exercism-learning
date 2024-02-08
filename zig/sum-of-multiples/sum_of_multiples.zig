const std = @import("std");
const mem = std.mem;

pub fn sum(allocator: mem.Allocator, factors: []const u32, limit: u32) !u64 {
    var num_hash = std.AutoArrayHashMap(u32, void).init(allocator);
    defer num_hash.deinit();

    for (factors) |f| {
        if (f == 0) continue;
        const factor_count: u32 = (limit - 1) / f;
        for (1..factor_count + 1) |i| {
            try num_hash.put(@as(u32, @truncate(i)) * f, {});
        }
    }

    var mul_sum: u64 = 0;
    for (num_hash.keys()) |key| {
        mul_sum += key;
    }
    return mul_sum;
}
