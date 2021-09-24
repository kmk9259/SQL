--1
SELECT
    STUDENT_NAME 학생이름,
    STUDENT_ADDRESS 주소지
FROM TB_STUDENT
ORDER BY 1;

--2
SELECT
    STUDENT_NAME,
    STUDENT_SSN
FROM TB_STUDENT
WHERE ABSENCE_YN='Y'
ORDER BY 2 DESC;

--3
SELECT
    STUDENT_NAME 학생이름,
    STUDENT_NO 학번,
    STUDENT_ADDRESS 주소지
FROM TB_STUDENT
WHERE STUDENT_ADDRESS LIKE '%강원도%' 
OR STUDENT_ADDRESS LIKE '%경기도%'
AND STUDENT_NO LIKE '9%'
ORDER BY 1;

--4
SELECT
    A.PROFESSOR_NAME,
    A.PROFESSOR_SSN
FROM TB_PROFESSOR A
JOIN TB_DEPARTMENT B ON A.DEPARTMENT_NO = B.DEPARTMENT_NO
WHERE B.DEPARTMENT_NAME LIKE '법학%'
ORDER BY 2;

--5
SELECT
    STUDENT_NO,
    TO_CHAR(POINT,'9.99') POINT
FROM TB_GRADE 
WHERE TERM_NO='200402' 
AND CLASS_NO='C3118100'
ORDER BY 2 DESC,1;

--6
SELECT
    A.STUDENT_NO,
    A.STUDENT_NAME,
    B.DEPARTMENT_NAME
FROM TB_STUDENT A
JOIN TB_DEPARTMENT B ON A.DEPARTMENT_NO = B.DEPARTMENT_NO
ORDER BY 2;

--7
SELECT
    A.CLASS_NAME,
    B.DEPARTMENT_NAME
FROM TB_CLASS A
JOIN TB_DEPARTMENT B ON A.DEPARTMENT_NO = B.DEPARTMENT_NO;

--8
SELECT
    A.CLASS_NAME,
    C.PROFESSOR_NAME
FROM TB_CLASS A
JOIN TB_CLASS_PROFESSOR B ON A.CLASS_NO = B.CLASS_NO
JOIN TB_PROFESSOR C ON B.PROFESSOR_NO = C.PROFESSOR_NO
ORDER BY 2 ,1;
                            
--9
SELECT
    A.CLASS_NAME,
    C.PROFESSOR_NAME
FROM TB_CLASS A
JOIN TB_CLASS_PROFESSOR B ON A.CLASS_NO = B.CLASS_NO
JOIN TB_PROFESSOR C ON B.PROFESSOR_NO = C.PROFESSOR_NO
JOIN TB_DEPARTMENT D ON C.DEPARTMENT_NO = D.DEPARTMENT_NO
WHERE D.CATEGORY LIKE '인문사회%'
ORDER BY 2,1;

--10
SELECT
    A.STUDENT_NO 학번,
    A.STUDENT_NAME 학생이름,
    ROUND(AVG(B.POINT),1) 전체평점
FROM TB_STUDENT A
JOIN TB_GRADE B ON A.STUDENT_NO = B.STUDENT_NO
JOIN TB_DEPARTMENT C ON A.DEPARTMENT_NO = C.DEPARTMENT_NO
WHERE C.DEPARTMENT_NAME LIKE '%음악%'
GROUP BY A.STUDENT_NO, A.STUDENT_NAME
ORDER BY 3 DESC;

--11
SELECT
    B.DEPARTMENT_NAME 학과이름,
    A.STUDENT_NAME 학생이름,
    C.PROFESSOR_NAME 지도교수이름
FROM TB_STUDENT A
JOIN TB_DEPARTMENT B ON A.DEPARTMENT_NO = B.DEPARTMENT_NO
JOIN TB_PROFESSOR C ON A.COACH_PROFESSOR_NO = C.PROFESSOR_NO
WHERE A.STUDENT_NO ='A313047';

--12
SELECT
    A.STUDENT_NAME,
    B.TERM_NO AS TERM_NAME
FROM TB_STUDENT A
JOIN TB_GRADE B ON A.STUDENT_NO = B.STUDENT_NO
JOIN TB_CLASS C ON B.CLASS_NO = C.CLASS_NO
WHERE B.TERM_NO LIKE '2007%'
AND C.CLASS_NAME='인간관계론';

--13
SELECT
    CLASS_NAME,
    DEPARTMENT_NAME
FROM TB_CLASS A
LEFT JOIN TB_CLASS_PROFESSOR B ON A.CLASS_NO = B.CLASS_NO
LEFT JOIN TB_DEPARTMENT C ON A.DEPARTMENT_NO = C.DEPARTMENT_NO
WHERE C.CATEGORY ='예체능'
AND PROFESSOR_NO IS NULL
ORDER BY 2;

--14
SELECT
    A.STUDENT_NAME 학생이름,
    NVL(B.PROFESSOR_NAME, '지도교수 미지정') 지도교수
FROM TB_STUDENT A
LEFT JOIN TB_PROFESSOR B ON A.COACH_PROFESSOR_NO = B.PROFESSOR_NO
WHERE A.DEPARTMENT_NO = (SELECT
                            DEPARTMENT_NO
                        FROM TB_DEPARTMENT
                        WHERE DEPARTMENT_NAME LIKE '서%')
ORDER BY A.STUDENT_NO;
--15
SELECT
    A.STUDENT_NO 학번,
    A.STUDENT_NAME 이름,
    B.DEPARTMENT_NAME 학과이름,
    ROUND(AVG(C.POINT),8) 평점
FROM TB_STUDENT A
LEFT JOIN TB_DEPARTMENT B ON A.DEPARTMENT_NO = B.DEPARTMENT_NO
LEFT JOIN TB_GRADE C ON A.STUDENT_NO = C.STUDENT_NO
WHERE A.ABSENCE_YN='N'
GROUP BY A.STUDENT_NO,
         A.STUDENT_NAME ,
         B.DEPARTMENT_NAME
HAVING AVG(C.POINT)>=4.0
ORDER BY 4 DESC;

--16
SELECT
    A.CLASS_NO,
    A.CLASS_NAME,
    ROUND(AVG(B.POINT),8)
FROM TB_CLASS A
LEFT JOIN TB_GRADE B ON A.CLASS_NO = B.CLASS_NO
LEFT JOIN TB_DEPARTMENT C ON A.DEPARTMENT_NO = C.DEPARTMENT_NO
WHERE DEPARTMENT_NAME='환경조경학과'
AND A.CLASS_TYPE LIKE '%전공%'
GROUP BY A.CLASS_NO,
         A.CLASS_NAME
ORDER BY 3 DESC;

--17
SELECT
    STUDENT_NAME,
    STUDENT_ADDRESS
FROM TB_STUDENT
WHERE DEPARTMENT_NO = (SELECT
                        DEPARTMENT_NO
                        FROM TB_STUDENT
                        WHERE STUDENT_NAME='최경희'
                       );
                       
--18 다시
SELECT
    A.STUDENT_NO,
    A.STUDENT_NAME,
    MAX(AVG(C.POINT))
FROM TB_STUDENT A
LEFT JOIN TB_DEPARTMENT B ON A.DEPARTMENT_NO = B.DEPARTMENT_NO
LEFT JOIN TB_GRADE C ON A.STUDENT_NO = C.STUDENT_NO
WHERE B.DEPARTMENT_NAME ='국어국문학과'

GROUP BY A.STUDENT_NO, 
         A.STUDENT_NAME,
         C.POINT;

--19
SELECT
    C.DEPARTMENT_NAME 계열학과명,
    ROUND(AVG(A.POINT),1) 전공평점
FROM TB_GRADE A
JOIN TB_CLASS B ON A.CLASS_NO = B.CLASS_NO
JOIN TB_DEPARTMENT C ON B.DEPARTMENT_NO = C.DEPARTMENT_NO
WHERE C.CATEGORY =(SELECT
                        CATEGORY
                    FROM TB_DEPARTMENT A
                    WHERE DEPARTMENT_NAME LIKE '환경조경%'
                    ) 
AND CLASS_TYPE LIKE '%전공%'
GROUP BY DEPARTMENT_NAME;
