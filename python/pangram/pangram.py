def is_pangram(sentence: str) -> bool:
    return len(set([char.lower() for char in sentence if char.isalpha()])) == 26
