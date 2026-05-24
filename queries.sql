-- =========================================
-- BASIC RETRIEVAL AND FILTERING
-- =========================================

-- 1. List all active students
SELECT student_id, full_name, email, batch_id, admission_date
FROM students
WHERE status = 'Active';

-- 2. Find students with invalid or missing email
SELECT student_id, full_name, email
FROM students
WHERE email IS NULL
OR email NOT LIKE '%@%.%';

-- 3. List Easy and Medium problems
SELECT problem_id, title, difficulty
FROM problems
WHERE difficulty IN ('Easy', 'Medium');

-- 4. Latest 20 submissions
SELECT *
FROM submissions
ORDER BY submitted_at DESC
LIMIT 20;

-- 5. Failed submissions
SELECT submission_id, student_id, status
FROM submissions
WHERE status <> 'Successful';

-- =========================================
-- JOINS
-- =========================================

-- 6. Submission details with student and problem info
SELECT s.submission_id,
       st.full_name,
       p.title,
       s.language,
       s.status,
       s.score,
       s.submitted_at
FROM submissions s
JOIN students st
ON s.student_id = st.student_id
JOIN problems p
ON s.problem_id = p.problem_id;

-- 7. Students with enrollments including non-enrolled students
SELECT st.student_id,
       st.full_name,
       e.course_id
FROM students st
LEFT JOIN enrollments e
ON st.student_id = e.student_id;

-- 8. Courses with number of enrolled students
SELECT c.course_name,
       COUNT(e.student_id) AS total_students
FROM courses c
LEFT JOIN enrollments e
ON c.course_id = e.course_id
GROUP BY c.course_name;

-- 9. Test case results for each submission
SELECT tr.result_id,
       st.full_name,
       p.title,
       tr.passed
FROM test_results tr
JOIN submissions s
ON tr.submission_id = s.submission_id
JOIN students st
ON s.student_id = st.student_id
JOIN problems p
ON s.problem_id = p.problem_id;

-- 10. Students enrolled but never submitted
SELECT DISTINCT st.student_id,
       st.full_name
FROM students st
JOIN enrollments e
ON st.student_id = e.student_id
LEFT JOIN submissions s
ON st.student_id = s.student_id
WHERE s.submission_id IS NULL;

-- =========================================
-- AGGREGATION AND HAVING
-- =========================================

-- 11. Count submissions by status
SELECT status,
       COUNT(*) AS total_submissions
FROM submissions
GROUP BY status;

-- 12. Average score per problem
SELECT p.title,
       AVG(s.score) AS avg_score
FROM submissions s
JOIN problems p
ON s.problem_id = p.problem_id
GROUP BY p.title;

-- 13. Students with more than 5 submissions
SELECT student_id,
       COUNT(*) AS total_submissions
FROM submissions
GROUP BY student_id
HAVING COUNT(*) > 5;

-- 14. Problems with success rate below 40%
SELECT p.title,
       (SUM(CASE WHEN s.status='Successful' THEN 1 ELSE 0 END)*100.0/
       COUNT(*)) AS success_rate
FROM submissions s
JOIN problems p
ON s.problem_id = p.problem_id
GROUP BY p.title
HAVING (SUM(CASE WHEN s.status='Successful' THEN 1 ELSE 0 END)*100.0/
       COUNT(*)) < 40;

-- 15. Top 10 most attempted problems
SELECT p.title,
       COUNT(s.submission_id) AS attempts
FROM problems p
JOIN submissions s
ON p.problem_id = s.problem_id
GROUP BY p.title
ORDER BY attempts DESC
LIMIT 10;

-- =========================================
-- SUBQUERIES
-- =========================================

-- 16. Students with above average score
SELECT student_id,
       AVG(score) AS avg_score
FROM submissions
GROUP BY student_id
HAVING AVG(score) >
(
    SELECT AVG(score)
    FROM submissions
);

-- 17. Problems never attempted
SELECT title
FROM problems
WHERE problem_id NOT IN
(
    SELECT DISTINCT problem_id
    FROM submissions
);

-- 18. Students enrolled but never submitted
SELECT full_name
FROM students
WHERE student_id IN
(
    SELECT student_id
    FROM enrollments
)
AND student_id NOT IN
(
    SELECT DISTINCT student_id
    FROM submissions
);

-- 19. Students who used both Python and Java
SELECT student_id
FROM submissions
WHERE language IN ('Python', 'Java')
GROUP BY student_id
HAVING COUNT(DISTINCT language) = 2;

-- 20. Second highest score for a problem
SELECT MAX(score) AS second_highest
FROM submissions
WHERE problem_id = 1
AND score <
(
    SELECT MAX(score)
    FROM submissions
    WHERE problem_id = 1
);
