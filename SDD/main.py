def calcGrade(courseworkMark: int, examMark: int) -> str:
    # Validate courseworkMark argument
    if type(courseworkMark) is not int:
        raise TypeError("courseworkMark must be an integer")
    if not 0 <= courseworkMark <= 60:
        raise ValueError("courseworkMark must be between 0 and 60")

    # Validate examMark argument
    if type(examMark) is not int:
        raise TypeError("examMark must be an integer")
    if not 0 <= examMark <= 90:
        raise ValueError("examMark must be between 0 and 90")

    totalMark = courseworkMark + examMark
    floatPercentage = totalMark / 1.5
    percentage = int(floatPercentage)

    if 70 <= percentage:
        return "A"
    if 60 <= percentage:
        return "B"
    if 50 <= percentage:
        return "C"
    if 45 <= percentage:
        return "D"

    return "None"
