# Query Outputs and Validation

## Query 1

Purpose:
List all active students.

Sample Output:
| student_id | full_name | status |
|---|---|---|
| 101 | Rahul Sharma | Active |

Validation:
Only students marked as Active are displayed.

---

## Query 4

Purpose:
Display latest 20 submissions.

Result Summary:
The query returned the newest submissions sorted by timestamp.

Validation:
Records are ordered in descending order using submitted_at.

---

## Query 8

Purpose:
Count students enrolled in each course.

Sample Output:
| course_name | total_students |
|---|---|
| DBMS | 120 |

Validation:
COUNT function correctly calculates enrollments grouped by course.

---

## Query 14

Purpose:
Find problems with low success rate.

Result Summary:
Problems having success rate below 40% are displayed.

Validation:
The HAVING clause filters aggregated success percentage correctly.

---

## Query 17

Purpose:
Find problems never attempted.

Result Summary:
Only problems absent from submissions table are displayed.

Validation:
NOT IN subquery removes attempted problems.
