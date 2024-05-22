const std = @import("std");

pub fn primes(buffer: []u32, limit: u32) []u32 {
    if (limit <= 0 or limit > 1000) unreachable;
    var sieve = std.StaticBitSet(1001).initEmpty();
    var buf_i: usize = 0;
    for (2..limit + 1) |i| {
        // Skip all set
        if (sieve.isSet(i)) continue;

        // Add valid i to buffer
        buffer[buf_i] = @intCast(i);
        buf_i += 1;

        // Set all multiply of i which is <= limit
        var j = i * i;
        while (j <= limit) : (j += i)
            sieve.set(j);
    }
    return buffer[0..buf_i];
}
