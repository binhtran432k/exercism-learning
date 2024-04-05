const std = @import("std");
const ascii = @import("std").ascii;

pub fn response(s: []const u8) []const u8 {
    const trim_s = std.mem.trim(u8, s, &ascii.whitespace);

    if (trim_s.len == 0)
        return "Fine. Be that way!";

    const is_question = trim_s[trim_s.len - 1] == '?';
    const is_capital = isAllCapital(s);

    if (is_question and is_capital)
        return "Calm down, I know what I'm doing!";

    if (is_question)
        return "Sure.";

    if (is_capital)
        return "Whoa, chill out!";

    return "Whatever.";
}

fn isAllCapital(s: []const u8) bool {
    var upper_flag = false;
    for (s) |c| {
        if (ascii.isLower(c)) return false;
        if (ascii.isUpper(c)) upper_flag = true;
    }
    return upper_flag;
}
