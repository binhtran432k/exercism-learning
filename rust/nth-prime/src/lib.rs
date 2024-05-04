pub fn nth(n: u32) -> u32 {
    (2..3)
        .chain((3..).step_by(2).filter(|&x| is_prime_not_two(x)))
        .nth(n as usize)
        .unwrap()
}

fn is_prime_not_two(n: u32) -> bool {
    !(2..3)
        .chain((3..=(n as f64).sqrt() as u32).step_by(2))
        .any(|x| n % x == 0)
}
