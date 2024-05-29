const std = @import("std");
const mem = std.mem;

pub const Signal = enum(u5) {
    wink = 1 << 0,
    double_blink = 1 << 1,
    close_your_eyes = 1 << 2,
    jump = 1 << 3,
};

pub fn calculateHandshake(allocator: mem.Allocator, number: u5) mem.Allocator.Error![]const Signal {
    var signals = try allocator.alloc(Signal, @popCount(number & ~(@as(u5, 1) << 4)));
    errdefer allocator.free(signals);

    var i: std.math.Log2Int(u5) = 0;
    inline for (std.meta.fields(Signal)) |signal| {
        if (number & signal.value != 0) {
            signals[i] = @field(Signal, signal.name);
            i += 1;
        }
    }

    if (number & (1 << 4) != 0)
        std.mem.reverse(Signal, signals);

    return signals;
}
