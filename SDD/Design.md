# Design

> ### Programming task
>
> This assessment task combines designing and developing a program to meet the problem specification, and then using the internal commentary > of your program, and an additional question, to meet Outcome 1 and 2.
>
> To pass this assessment, you will have to complete all the steps, show your assessor your working program, and hand in all the hard copy > evidence of the work you have completed.
>
> You can document your achievement in the programming tasks checklist.
>
> Evidence of sufficient programming tasks should be appropriately labelled with your name, date(s) of completion, and your assessor’s > comments (if any). Evidence may be kept in electronic or hard copy form.
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

Main program

```
Take coursework mark from input
Validate coursework mark is an integer
Validate coursework mark is between 0 and 60

Take prelim mark from input
Validate prelim mark is an integer
Validate prelim mark is between 0 and 90

Add coursework and prelim marks together, giving total mark
Divide total mark by 1.5, giving float percentage
Convert float percentage to integer, giving percentage

Match percentage against:
	70 <= % -> A
	60 <= % < 70 -> B
	50 <= % < 60 -> C
	45 <= % < 49 -> D
	otherwise -> None
giving grade for total course

Print grade for total course
```
