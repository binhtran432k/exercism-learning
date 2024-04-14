pub fn is_armstrong_number(num: u32) -> bool {
    if num <= 9 {
        return true;
    }
    let digit_len = num.ilog10() + 1;
    (0..digit_len)
        .try_fold((num, num), |(check_n, n), _| {
            let (digit, next_n) = (n % 10, n / 10);
            check_n
                .checked_sub(digit.pow(digit_len))
                .map(|next_check_n| (next_check_n, next_n))
        })
        .is_some_and(|(check_n, _)| check_n == 0)
}
