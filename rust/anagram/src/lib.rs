use std::collections::HashSet;

pub fn encode(word: &str) -> Vec<char> {
    let mut encrypt_word: Vec<char> = word.chars().collect();
    encrypt_word.sort_unstable();
    encrypt_word
}

pub fn anagrams_for<'a>(word: &str, possible_anagrams: &[&'a str]) -> HashSet<&'a str> {
    let lower_word = word.to_lowercase();
    let encrypt_word = encode(&lower_word);
    possible_anagrams
        .iter()
        .filter(|candidate| {
            let lower_candidate = candidate.to_lowercase();
            lower_word.len() == lower_candidate.len()
                && lower_word != lower_candidate
                && encrypt_word == encode(&lower_candidate)
        })
        .copied()
        .collect()
}
