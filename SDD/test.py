from main import calcGrade
import unittest

test = unittest.TestCase()
raises = test.assertRaises
equal = test.assertEqual

# Invalid arguments
raises(TypeError, calcGrade)
raises(TypeError, calcGrade, 1)

raises(TypeError, calcGrade, "string", 0)
raises(TypeError, calcGrade, 50.5, 90)
raises(ValueError, calcGrade, 61, 90)
raises(ValueError, calcGrade, -1, 90)

raises(TypeError, calcGrade, 0, "string")
raises(TypeError, calcGrade, 60, 50.5)
raises(ValueError, calcGrade, 60, 91)
raises(ValueError, calcGrade, 60, -1)

# Correct grades for total course
equal(calcGrade(60, 90), "A")
equal(calcGrade(60, 70), "A")
equal(calcGrade(50, 80), "A")
equal(calcGrade(50, 60), "A")

equal(calcGrade(50, 50), "B")
equal(calcGrade(40, 50), "B")
equal(calcGrade(0, 90), "B")

equal(calcGrade(40, 45), "C")
equal(calcGrade(40, 40), "C")
equal(calcGrade(40, 35), "C")

equal(calcGrade(40, 30), "D")
equal(calcGrade(35, 35), "D")

equal(calcGrade(35, 30), "None")
equal(calcGrade(60, 0), "None")
equal(calcGrade(0, 0), "None")

print("All tests passed successfully!")
