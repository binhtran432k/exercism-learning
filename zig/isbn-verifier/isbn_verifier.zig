pub fn isValidIsbn10(s: []const u8) bool {
    var sum: u16 = 0;
    var digit: u4 = 10;
    for (s) |c| {
        if (digit == 0)
            return false;

        const inc: u16 = switch (c) {
            '0'...'9' => @intCast(c - '0'),
            'X' => if (digit == 1) 10 else return false,
            '-' => continue,
            else => return false,
        };
        sum += inc * digit;
        digit -= 1;
    } else if (digit > 0) {
        return false;
    }

    return @rem(sum, 11) == 0;
}
