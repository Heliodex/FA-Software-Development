from step2 import readStudentsFromFile, countAPasses, findBestMark

students = readStudentsFromFile("class_marks.csv")

aPasses = countAPasses(students)
print(f"There are {aPasses} A passes")

bestStudent = findBestMark(students)
print(f"The student with the best mark is {bestStudent.name} with a result of {bestStudent.totalPercentage}%")
