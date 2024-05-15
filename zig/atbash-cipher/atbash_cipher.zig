const std = @import("std");
const mem = std.mem;

/// Encodes `s` using the Atbash cipher. Caller owns the returned memory.
pub fn encode(allocator: mem.Allocator, s: []const u8) mem.Allocator.Error![]u8 {
    var new_s = try std.ArrayList(u8).initCapacity(allocator, s.len + s.len / 5);
    errdefer new_s.deinit();
    var i: u3 = 0;
    for (s) |c| {
        if (charCode(c)) |e| {
            if (i == 5) {
                new_s.appendAssumeCapacity(' ');
                i = 0;
            }
            new_s.appendAssumeCapacity(e);
            i += 1;
        }
    }
    return new_s.toOwnedSlice();
}

/// Decodes `s` using the Atbash cipher. Caller owns the returned memory.
pub fn decode(allocator: mem.Allocator, s: []const u8) mem.Allocator.Error![]u8 {
    var new_s = try std.ArrayList(u8).initCapacity(allocator, s.len);
    errdefer new_s.deinit();
    for (s) |c| {
        if (charCode(c)) |d|
            new_s.appendAssumeCapacity(d);
    }
    return new_s.toOwnedSlice();
}

fn charCode(c: u8) ?u8 {
    return switch (c) {
        'a'...'z' => 'a' + 'z' - c,
        'A'...'Z' => 'a' + 'Z' - c,
        '0'...'9' => c,
        else => null,
    };
}
