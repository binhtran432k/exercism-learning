const std = @import("std");
const mem = std.mem;

pub const ConversionError = error{
    InvalidInputBase,
    InvalidOutputBase,
    InvalidDigit,
};

/// Converts `digits` from `input_base` to `output_base`, returning a slice of digits.
/// Caller owns the returned memory.
pub fn convert(
    allocator: mem.Allocator,
    digits: []const u32,
    input_base: u32,
    output_base: u32,
) (mem.Allocator.Error || ConversionError)![]u32 {
    if (input_base <= 1)
        return error.InvalidInputBase;
    if (output_base <= 1)
        return error.InvalidOutputBase;

    var base_number: u32 = 0;
    for (digits, 0..) |d, i| {
        if (d < 0 or d >= input_base)
            return error.InvalidDigit;
        const digit_i = digits.len - 1 - i;
        base_number += d * std.math.pow(u32, input_base, @as(u32, @truncate(digit_i)));
    }

    const output_length = if (base_number <= 1) 1 else std.math.log(u32, output_base, base_number) + 1;
    var output_digits = try allocator.alloc(u32, output_length);
    errdefer allocator.free(output_digits);

    for (0..output_length) |i| {
        output_digits[output_length - 1 - i] = @rem(base_number, output_base);
        base_number = @divTrunc(base_number, output_base);
    }

    return output_digits;
}
