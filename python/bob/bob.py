def response(hey_bob: str) -> str:
    strip_hey_bob = hey_bob.strip()
    if not strip_hey_bob:
        return "Fine. Be that way!"
    if strip_hey_bob[-1] == '?':
        if strip_hey_bob.isupper():
            return "Calm down, I know what I'm doing!"
        return "Sure."
    if strip_hey_bob.isupper():
        return "Whoa, chill out!"
    return "Whatever."