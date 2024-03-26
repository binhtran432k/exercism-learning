def is_armstrong_number(number: int) -> bool:
    return sum([int(x) ** len(str(number)) for x in str(number)]) == number
