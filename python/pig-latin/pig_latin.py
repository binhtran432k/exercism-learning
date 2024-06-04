def translate(text: str) -> str:
    result = ""
    word = ""
    for c in text:
        if c.isspace():
            if word:
                result += translate_word(word)
                word = ""
            result += c
        else:
            word += c
    if word:
        result += translate_word(word)
        word = ""
    return result

def translate_word(text: str) -> str:
    if is_vowel(text[0]) or text.startswith("xr") or text.startswith("yt"):
        return text + "ay"
    for i in range(len(text)):
        if i > 0 and (is_vowel(text[i]) or text[i] == 'y'):
            return text[i:] + text[:i] + "ay"
        if text[i:i+2] == 'qu':
            return text[i+2:] + text[:i+2] + "ay"
    return text

def is_vowel(c: str) -> bool:
    return "aeiou".find(c) != -1