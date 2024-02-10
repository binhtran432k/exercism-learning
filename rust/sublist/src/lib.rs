#[derive(Debug, PartialEq, Eq)]
pub enum Comparison {
    Equal,
    Sublist,
    Superlist,
    Unequal,
}

pub fn sublist<T: PartialEq>(_first_list: &[T], _second_list: &[T]) -> Comparison {
    match (_first_list.len(), _second_list.len()) {
        (0, 0) => Comparison::Equal,
        (0, _) => Comparison::Sublist,
        (_, 0) => Comparison::Superlist,
        (m, n) if m < n => sublist_fallback(_first_list, _second_list, Comparison::Sublist),
        (m, n) if m > n => sublist_fallback(_second_list, _first_list, Comparison::Superlist),
        (_, _) if _first_list == _second_list => Comparison::Equal,
        (_, _) => Comparison::Unequal,
    }
}

fn sublist_fallback<T: PartialEq>(smalls: &[T], bigs: &[T], fallback: Comparison) -> Comparison {
    if bigs.windows(smalls.len()).any(|x| x == smalls) {
        fallback
    } else {
        Comparison::Unequal
    }
}
