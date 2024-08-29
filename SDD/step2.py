from main import calcGrade
from dataclasses import dataclass


@dataclass  # Allows for easy creation of classes with attributes
class Student:
    """A class to represent a student, with their name and marks"""

    name: str
    courseworkMark: int
    examMark: int

    @property
    def totalMark(self) -> int:
        """Calculates the total mark for a student"""
        return self.courseworkMark + self.examMark

    @property
    def grade(self) -> str:
        """Calculates the grade for a student"""
        return calcGrade(self.courseworkMark, self.examMark)


def readStudentsFromFile() -> list[Student]:
    """Reads students from a CSV file and returns them as a list of Student objects"""
    file = open("class_marks.csv", "r")  # Reads file from disk into memory
    lines = file.readlines()  # Splits file by newlines into a list
    file.close()  # Closes file, removing it from memory

    students: list[Student] = []  # Creates an empty list to store students

    for line in lines:
        # Splits line by commas into a list
        parts = line.split(",")

        # CSV file is name, coursework, exam (no header row)
        name = parts[0]
        courseworkMark = int(parts[1])
        examMark = int(parts[2])

        # Create a new Student object and append it to the list
        student = Student(name, courseworkMark, examMark)
        students.append(student)

    return students


def countAPasses(students: list[Student]) -> int:
    """Counts the number of students who achieved an A grade"""
    # Count Occurences algorithm
    aPasses = 0

    # Loop over all the students and check if they match the criteria
    for student in students:
        if student.grade == "A":
            aPasses += 1  # Increment the count for each match

    return aPasses


# TODO: Make this work when students may have the same highest mark
def findBestMark(students: list[Student]) -> Student:
    """Finds the student with the highest mark"""
    # Finding the maximum algorithm
    bestStudent = students[0]  # Start with the first student to compare against

    # Loop over the rest of the students and check if they have a better mark
    for student in students[1:]:
        if student.totalMark > bestStudent.totalMark:
            bestStudent = student  # Update the best student if a new maximum is found

    return bestStudent
