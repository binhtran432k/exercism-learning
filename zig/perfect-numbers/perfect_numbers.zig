pub const Classification = enum {
    deficient,
    perfect,
    abundant,
};

/// Asserts that `n` is nonzero.
pub fn classify(n: u64) Classification {
    var aliquot_sum: u64 = 0;
    for (1..n / 2 + 1) |i| {
        if (@rem(n, i) == 0)
            aliquot_sum += i;
    }

    if (n == aliquot_sum)
        return .perfect
    else if (n < aliquot_sum)
        return .abundant
    else if (n > aliquot_sum)
        return .deficient;

    unreachable;
}
