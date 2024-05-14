const std = @import("std");

pub fn modifier(score: i8) i8 {
    return @divFloor(score - 10, 2);
}

pub fn ability() i8 {
    const seed = @as(u64, @truncate(@as(u128, @bitCast(std.time.nanoTimestamp()))));
    var prng = std.rand.DefaultPrng.init(seed);
    const rand = prng.random();
    return randomDice(rand) + randomDice(rand) + randomDice(rand);
}

pub const Character = struct {
    strength: i8,
    dexterity: i8,
    constitution: i8,
    intelligence: i8,
    wisdom: i8,
    charisma: i8,
    hitpoints: i8,

    pub fn init() Character {
        const constitution = ability();
        const hitpoints = 10 + modifier(constitution);
        return Character{ .strength = ability(), .dexterity = ability(), .constitution = constitution, .intelligence = ability(), .wisdom = ability(), .charisma = ability(), .hitpoints = hitpoints };
    }
};

fn randomDice(rand: std.rand.Random) i8 {
    return rand.intRangeAtMost(i8, 1, 6);
}
