from main import calcGrade

file = open("class_marks.csv", "r")  # Reads file from disk into memory
lines = file.readlines()  # Splits file by newlines into a list
file.close()  # Closes file, removing it from memory


class Student:
    """A class to represent a student, with their name and grade"""

    def __init__(self, name: str, grade: str):
        self.name = name
        self.grade = grade


grades: list[Student] = []  # Creates an empty list to store grades

for line in lines:
    # Splits line by commas into a list
    parts = line.split(",")

    # CSV file is name, coursework, exam (no header row)
    name = parts[0]
    courseworkMark = int(parts[1])
    examMark = int(parts[2])
    result = calcGrade(courseworkMark, examMark)

    # Create a new Student object and append it to the list
    student = Student(name, result)
    grades.append(student)
