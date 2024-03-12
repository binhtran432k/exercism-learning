pub fn isIsogram(str: []const u8) bool {
    var iso_phrase: u26 = 0;
    for (str) |c| {
        const idx: u5 = @intCast(switch (c) {
            'a'...'z' => c - 'a',
            'A'...'Z' => c - 'A',
            else => continue,
        });
        const char_flag = @as(u26, 1) << idx;
        if (iso_phrase & char_flag != 0) {
            return false;
        }
        iso_phrase |= char_flag;
    }
    return true;
}
