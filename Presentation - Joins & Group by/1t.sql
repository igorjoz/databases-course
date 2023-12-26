SELECT students.sno, students.syear, teachers.tname
FROM teachers INNER JOIN (students INNER JOIN teachings ON students.[sno] = teachings.[sno]) ON teachers.[tno] = teachings.[tno];
