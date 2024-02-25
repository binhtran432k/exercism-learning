fn get_score(c: u8) u32 {
    return switch (c) {
        'a', 'e', 'i', 'o', 'u', 'l', 'n', 'r', 's', 't' => 1,
        'd', 'g' => 2,
        'b', 'c', 'm', 'p' => 3,
        'f', 'h', 'v', 'w', 'y' => 4,
        'k' => 5,
        'j', 'x' => 8,
        'q', 'z' => 10,
        else => 0,
    };
}

fn get_lowercase(c: u8) u8 {
    if ('A' <= c and c <= 'Z') {
        return c + ('a' - 'A');
    }
    return c;
}

pub fn score(s: []const u8) u32 {
    var sum: u32 = 0;
    for (s) |c| {
        sum += get_score(get_lowercase(c));
    }
    return sum;
}
