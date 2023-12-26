SELECT students.sno, students.syear, teachers.tname
FROM teachers INNER JOIN (students INNER JOIN teachings ON students.[sno] = teachings.[sno]) ON teachers.[tno] = teachings.[tno];


SELECT "London" AS city, COUNT(teachers.city) AS teachers_from_city_quantity
FROM teachers
WHERE teachers.city LIKE "*London*";

SELECT teachers.city, COUNT(*) AS teachers_from_city_quantity
FROM teachers
GROUP BY teachers.city;


SELECT genre, AVG(price)
FROM books
GROUP BY genre;

SELECT tno, COUNT(*) AS students_number
FROM teachings
GROUP BY tno;


SELECT sno, SUM(hours) AS sum_of_hours
FROM teachings
GROUP BY sno
HAVING SUM(hours) > 160
ORDER BY SUM(hours) DESC;


SELECT students.sname, teachings.sno, teachings.hours
FROM teachings, students
WHERE teachings.sno = students.sno AND tno = 4
ORDER BY sname;


SELECT students.sname, teachings.sno, teachings.hours
FROM teachings JOIN students
ON teachings.sno = students.sno
WHERE  tno = 4
ORDER BY sname;

SELECT students.sname, students.sno, teachings.hours
FROM students INNER JOIN teachings
ON students.sno = teachings.sno
WHERE teachings.tno=4
ORDER BY students.sname;


SELECT students.sname, students.sno, teachings.hours
FROM teachings JOIN students
USING(sno)
WHERE teachings.tno=4
ORDER BY students.sname;


SELECT students.sname, students.sno, teachings.hours
FROM teachings NATURAL JOIN students
WHERE teachings.tno=4
ORDER BY students.sname;


SELECT teachers.city, teachers.tname, teachers.tno, students.sname, students.sno
FROM teachers, students
WHERE teachers.city = students.city
ORDER BY teachers.city, teachers.tname, students.sname;



SELECT teachers.tname, teachings.tno, SUM(hours) AS sum_of_hours 
FROM teachers, teachings
WHERE teachers.tno = teachings.tno
GROUP BY teachers.tname, teachings.tno
ORDER BY teachers.tname;

SELECT teachers.tname, teachings.tno, SUM(hours) AS sum_of_hours 
FROM teachers NATURAL JOIN teachings
GROUP BY teachers.tname, teachings.tno
ORDER BY teachers.tname;



SELECT over.tname, over.tno, "is_the_boss_of" AS info, under.tname, under.tno
FROM teachers AS under INNER JOIN teachers AS over
ON under.tno = over.supno
WHERE under.supno=over.tno
ORDER BY over.tname, under.tname;
