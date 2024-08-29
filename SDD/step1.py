from main import calcGrade

# Receive marks from input
courseworkMark = int(input("Enter your coursework mark: "))
examMark = int(input("Enter your exam mark: "))

result = calcGrade(courseworkMark, examMark)
print(result)
