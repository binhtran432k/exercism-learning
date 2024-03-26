def steps(number: int) -> int:
    if number <= 0:
        raise ValueError("Only positive integers are allowed")
    counter = 0
    while number != 1:
        counter += 1
        number = 3 * number + 1 if number % 2 != 0 else number / 2
    return counter
