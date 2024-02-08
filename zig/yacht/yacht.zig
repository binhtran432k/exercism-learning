const std = @import("std");

pub const Category = enum(u4) {
    ones = 1,
    twos = 2,
    threes = 3,
    fours = 4,
    fives = 5,
    sixes = 6,
    full_house,
    four_of_a_kind,
    little_straight,
    big_straight,
    choice,
    yacht,
};

pub fn score(dice: [5]u3, category: Category) u32 {
    const sorted = blk: {
        var _sorted: [5]u3 = undefined;
        std.mem.copy(u3, &_sorted, &dice);
        std.mem.sort(u3, &_sorted, {}, std.sort.asc(u3));
        break :blk _sorted;
    };
    return switch (category) {
        .ones, .twos, .threes, .fours, .fives, .sixes => getScoreBySmallDice(&sorted, @truncate(@intFromEnum(category))),
        .full_house => getScoreByFullHouse(&sorted),
        .four_of_a_kind => getScoreByFourOfAKind(&sorted),
        .little_straight => getScoreByList(&sorted, &[_]u3{ 1, 2, 3, 4, 5 }),
        .big_straight => getScoreByList(&sorted, &[_]u3{ 2, 3, 4, 5, 6 }),
        .choice => getScoreByTotalOfDice(&sorted),
        .yacht => getScoreByYacht(&sorted),
    };
}

fn getScoreBySmallDice(dices: []const u3, n: u3) u32 {
    var count: u32 = 0;
    for (dices) |d| {
        if (d == n) count += 1;
    }
    return count * n;
}

fn getScoreByFullHouse(sorted_dices: []const u3) u32 {
    const match_firsts = sorted_dices[0] == sorted_dices[1];
    const match_middles_by_side = (sorted_dices[1] == sorted_dices[2]) != (sorted_dices[2] == sorted_dices[3]);
    const match_lasts = sorted_dices[3] == sorted_dices[4];
    return if (match_firsts and match_middles_by_side and match_lasts) getScoreByTotalOfDice(sorted_dices) else 0;
}

fn getScoreByFourOfAKind(sorted_dices: []const u3) u32 {
    const match_n_firsts = sorted_dices[0] == sorted_dices[3];
    const match_n_lasts = sorted_dices[1] == sorted_dices[4];
    return if (match_n_firsts or match_n_lasts) @as(u32, sorted_dices[2]) * 4 else 0;
}

fn getScoreByList(sorted_dices: []const u3, expected_dices: []const u3) u32 {
    return if (std.mem.eql(u3, sorted_dices, expected_dices)) 30 else 0;
}

fn getScoreByTotalOfDice(dices: []const u3) u32 {
    var sum: u32 = 0;
    for (dices) |d| sum += d;
    return sum;
}

fn getScoreByYacht(sorted_dices: []const u3) u32 {
    const match_all = sorted_dices[0] == sorted_dices[4];
    return if (match_all) 50 else 0;
}
