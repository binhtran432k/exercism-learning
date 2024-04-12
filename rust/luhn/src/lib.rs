/// Check a Luhn checksum.
pub fn is_valid(code: &str) -> bool {
    return code
        .chars()
        .rev()
        .filter(|&x| x != ' ')
        .try_fold((0, 0), |(sum, count), c| {
            c.to_digit(10)
                .map(|n| {
                    if count % 2 == 0 {
                        n
                    } else if 2 * n <= 9 {
                        2 * n
                    } else {
                        2 * n - 9
                    }
                })
                .map(|n| (sum + n, count + 1))
        })
        .map_or(false, |(sum, count)| count > 1 && sum % 10 == 0);
}
