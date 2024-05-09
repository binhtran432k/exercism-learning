pub fn factors(n: u64) -> Vec<u64> {
    let mut rt = Vec::new();
    let mut n = n;
    for i in (2..3).chain((3..=f64::sqrt(n as f64) as u64).step_by(2)) {
        while n % i == 0 {
            rt.push(i);
            n /= i;
        }
    }
    if n > 1 {
        rt.push(n);
    }
    rt
}
