# SQL Reasoning

## LEFT JOIN vs INNER JOIN

I used LEFT JOIN in Query 7 because I wanted to display all students including those who are not enrolled in any course.

If INNER JOIN was used, students without enrollments would not appear.

---

## HAVING vs WHERE

I used HAVING in Query 13 because the filtering condition depends on aggregate COUNT values.

WHERE cannot filter aggregated results after GROUP BY.

---

## Use of Subquery

In Query 17, I used a subquery to find problems that never appeared in the submissions table.

This helped compare all problems against attempted problems.

---

## Duplicate Record Issue

In enrollment-related queries, duplicate enrollment records could incorrectly increase student counts.

Using UNIQUE constraints helps avoid this issue.

---

## Edge Case Considered

While checking invalid emails, I considered NULL values separately because missing emails should also be treated as invalid data.
