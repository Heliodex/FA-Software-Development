# Design

> ### Programming task
>
> This assessment task combines designing and developing a program to meet the problem specification, and then using the internal commentary of your program, and an additional question, to meet Outcome 1 and 2.
>
> To pass this assessment, you will have to complete all the steps, show your assessor your working program, and hand in all the hard copy evidence of the work you have completed.
>
> You can document your achievement in the programming tasks checklist.
>
> Evidence of sufficient programming tasks should be appropriately labelled with your name, date(s) of completion, and your assessor’s comments (if any). Evidence may be kept in electronic or hard copy form.
>
> Evidence for the successful completion of these Outcomes may be drawn from more than one programming task.
>
> ### Problem specification
>
> Your overall percentage grade in your SCQF level 6 Computing course is devised by adding the coursework mark (out of 60) to the exam mark > (out of 90) and then calculating the percentage.
>
> Usually the grades are awarded by the following percentages:
>
> -   A Grade is awarded for greater than or equal to 70%
> -   B Grade is awarded to those between 60% and 69%
> -   C Grade is awarded to those between 50% and 59%
> -   D Grade is awarded to those between 45% and 49%
> -   No Grade is given to those achieving less than 45%

## Step 1

Grade calculation function (takes coursework mark, exam mark)

```
Validate coursework mark is an integer
Validate coursework mark is between 0 and 60

Validate exam mark is an integer
Validate exam mark is between 0 and 90

Add coursework and exam marks together, giving total mark
Divide total mark by 1.5, giving float percentage
Convert float percentage to integer, giving percentage

Match percentage against:
	70 <= % -> A
	60 <= % < 70 -> B
	50 <= % < 60 -> C
	45 <= % < 49 -> D
	otherwise -> None
giving grade for total course
```

Main program

```
Take coursework mark from input
Take exam mark from input

Call grade calculation function with coursework and exam marks
Set result to grade calculation function result
Print result
```

## Step 2

Student class

```
Name (string)
Coursework mark (integer)
Exam mark (integer)

Total mark:
	Add coursework and exam marks together

Total percentage:
	Divide total mark by max mark (150), giving float percentage
	Multiply float percentage by 100, rounding to 1 decimal place

Grade:
	Call grade calculation function with coursework and exam marks
```

Read students from file function

```
Open file class_marks.csv for reading
Read lines from file into list
Close file, freeing it from  memory

Create empty list of Student objects

For each line in list:
	Split line into student name, coursework mark, and exam mark

	Convert coursework mark and exam mark to integers

	Create new Student object with student name and marks
	Append new Student to Student list

Return Student list
```

Count A passes function (takes Student list)

```
Set A passes to 0

For each student in Student list:
	If student grade is A:
		Increment A passes by 1

Return A passes
```

Find best student function (takes Student list)

```
Set best student to the first student

For each student in the rest of the Student list:
	If student total mark is greater than best student total mark:
		Set best student to student

Return best student
```

## Relation to the fetch-execute cycle

The program and its input is read, either from a file (disk) or from the user (stdin), into memory or CPU cache, with input accessible through variables in the program. The CPU activates the read line on the control bus and sending mimery addresses over the address bus to load program instructions (or their addresses) from memory into the program counter, and copies the data into the instruction register. 

The CPU's control unit decodes the data in the instruction register, and executes each instruction by sending them to the corresponding components such as the arithmetic logic unit (ALU) or floating-point unit (FPU). This process may be executed once or multiple times on more modern CPUs, with the results stored in memory, registers, or sent to output devices like the display (stdout) by the processor . The process repeats until the program has finished executing.

This is how programs written in machine code are executed on a computer, however as this implementation is written in Python, there are a few more layers of abstraction. The program directly executed by the CPU is the Python interpreter, a kind of virtual computer that reads and executes Python code instead of machine code. The Python interpreter reads and executes the program itself in a similar way the CPU would with a machine code program.
