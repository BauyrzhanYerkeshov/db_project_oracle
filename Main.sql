-- 1. Ќайдите наиболее попул€рные курсы на семестр (вы должны пройти количество семестров и год, и вывести список курсов с учител€ми)
CREATE OR REPLACE PROCEDURE proc_popular_course 
                (
                    p_year NUMBER,
                    p_term NUMBER,
                    p_type VARCHAR2
                ) IS    
    CURSOR cur_2016 IS 
        SELECT DISTINCT c.ders_kod, c.year, c.term, s.emp_id, s.type FROM course_selections_2016 c, course_sections s WHERE c.ders_kod = s.ders_kod 
                                    AND c.year = s.year AND s.term = c.term AND reg_date IS NOT NULL AND s.type = p_type AND c.term = p_term
                                    ORDER BY ((SELECT MAX(reg_date) FROM course_selections_2016 WHERE reg_date IS NOT NULL) 
                                    - (SELECT MIN(reg_date) FROM course_selections_2016 WHERE reg_date IS NOT NULL))
                                    / (SELECT COUNT(*) FROM course_selections_2016 WHERE reg_date IS NOT NULL);
    CURSOR cur_2017 IS 
        SELECT DISTINCT c.ders_kod, c.year, c.term, s.emp_id, s.type FROM course_selections_2017 c, course_sections s WHERE c.ders_kod = s.ders_kod 
                                    AND c.year = s.year AND s.term = c.term AND reg_date IS NOT NULL AND s.type = p_type AND c.term = p_term
                                    ORDER BY ((SELECT MAX(reg_date) FROM course_selections_2017 WHERE reg_date IS NOT NULL) 
                                    - (SELECT MIN(reg_date) FROM course_selections_2017 WHERE reg_date IS NOT NULL))
                                    / (SELECT COUNT(*) FROM course_selections_2017 WHERE reg_date IS NOT NULL);
    CURSOR cur_2018 IS 
        SELECT DISTINCT c.ders_kod, c.year, c.term, s.emp_id, s.type FROM course_selections_2018 c, course_sections s WHERE c.ders_kod = s.ders_kod 
                                    AND c.year = s.year AND s.term = c.term AND reg_date IS NOT NULL AND s.type = p_type AND c.term = p_term
                                    ORDER BY ((SELECT MAX(reg_date) FROM course_selections_2018 WHERE reg_date IS NOT NULL) 
                                    - (SELECT MIN(reg_date) FROM course_selections_2018 WHERE reg_date IS NOT NULL))
                                    / (SELECT COUNT(*) FROM course_selections_2018 WHERE reg_date IS NOT NULL);
    CURSOR cur_2019 IS 
        SELECT DISTINCT c.ders_kod, c.year, c.term, s.emp_id, s.type FROM course_selections_2019 c, course_sections s WHERE c.ders_kod = s.ders_kod 
                                    AND c.year = s.year AND s.term = c.term AND reg_date IS NOT NULL AND s.type = p_type AND c.term = p_term
                                    ORDER BY ((SELECT MAX(reg_date) FROM course_selections_2019 WHERE reg_date IS NOT NULL) 
                                    - (SELECT MIN(reg_date) FROM course_selections_2019 WHERE reg_date IS NOT NULL))
                                    / (SELECT COUNT(*) FROM course_selections_2019 WHERE reg_date IS NOT NULL);        
    v_ders_kod VARCHAR2(10);
    v_year NUMBER(4);
    v_term NUMBER(1);
    v_emp_id NUMBER(10);
    v_type VARCHAR2(1);
BEGIN
    IF p_year = 2016 THEN 
        OPEN cur_2016;
        LOOP
            FETCH cur_2016 INTO v_ders_kod, v_year, v_term, v_emp_id, v_type;
            EXIT WHEN cur_2016%NOTFOUND;
            IF v_emp_id IS NOT NULL THEN
                DBMS_OUTPUT.PUT_LINE(v_ders_kod || '  ' || v_emp_id || '  ' || v_type);
            ELSE
                DBMS_OUTPUT.PUT_LINE(v_ders_kod || '         ' || v_type);                
            END IF;
        END LOOP;
        CLOSE cur_2016;
    ELSIF p_year = 2017 THEN 
        OPEN cur_2017;
        LOOP
            FETCH cur_2017 INTO v_ders_kod, v_year, v_term, v_emp_id, v_type;
            EXIT WHEN cur_2017%NOTFOUND;
            IF v_emp_id IS NOT NULL THEN
                DBMS_OUTPUT.PUT_LINE(v_ders_kod || '  ' || v_emp_id || '  ' || v_type);
            ELSE
                DBMS_OUTPUT.PUT_LINE(v_ders_kod || '         ' || v_type);                
            END IF;
        END LOOP;
        CLOSE cur_2017;
    ELSIF p_year = 2018 THEN 
        OPEN cur_2018;
        LOOP
            FETCH cur_2018 INTO v_ders_kod, v_year, v_term, v_emp_id, v_type;
            EXIT WHEN cur_2018%NOTFOUND;
            IF v_emp_id IS NOT NULL THEN
                DBMS_OUTPUT.PUT_LINE(v_ders_kod || '  ' || v_emp_id || '  ' || v_type);
            ELSE
                DBMS_OUTPUT.PUT_LINE(v_ders_kod || '         ' || v_type);                
            END IF;
        END LOOP;
        CLOSE cur_2018;
    ELSIF p_year = 2019 THEN 
        OPEN cur_2019;
        LOOP
            FETCH cur_2019 INTO v_ders_kod, v_year, v_term, v_emp_id, v_type;
            EXIT WHEN cur_2019%NOTFOUND;
            IF v_emp_id IS NOT NULL THEN
                DBMS_OUTPUT.PUT_LINE(v_ders_kod || '  ' || v_emp_id || '  ' || v_type);
            ELSE
                DBMS_OUTPUT.PUT_LINE(v_ders_kod || '         ' || v_type);                
            END IF;
        END LOOP;
        CLOSE cur_2019;
    END IF;
END;

EXECUTE proc_popular_course(2016, 3, 'P');

/* 2. Ќайдите наиболее попул€рного преподавател€ в разделе дл€ семестра 
   (¬ы должны указать количество семестров, год и код предмета, а также 
   вывести преподавательскую практику и лекцию). 
   Ќапример, лекторы по технологии программировани€: »нструктор1, »нструктор2. 
   »нструкторы практики: ”читель1, учитель2, учитель3 */
CREATE OR REPLACE PROCEDURE proc_popular_teacher 
                (
                    p_year NUMBER,
                    p_term NUMBER,
                    p_type VARCHAR2
                ) IS    
    CURSOR cur_2016 IS 
        SELECT DISTINCT c.ders_kod, c.year, c.term, s.emp_id, s.type FROM course_selections_2016 c, course_sections s WHERE c.ders_kod = s.ders_kod 
                                    AND c.year = s.year AND s.term = c.term AND reg_date IS NOT NULL AND s.type = p_type AND c.term = p_term
                                    ORDER BY ((SELECT MAX(reg_date) FROM course_selections_2016 WHERE reg_date IS NOT NULL) 
                                    - (SELECT MIN(reg_date) FROM course_selections_2016 WHERE reg_date IS NOT NULL))
                                    / (SELECT COUNT(*) FROM course_selections_2016 WHERE reg_date IS NOT NULL);
    CURSOR cur_2017 IS 
        SELECT DISTINCT c.ders_kod, c.year, c.term, s.emp_id, s.type FROM course_selections_2017 c, course_sections s WHERE c.ders_kod = s.ders_kod 
                                    AND c.year = s.year AND s.term = c.term AND reg_date IS NOT NULL AND s.type = p_type AND c.term = p_term
                                    ORDER BY ((SELECT MAX(reg_date) FROM course_selections_2017 WHERE reg_date IS NOT NULL) 
                                    - (SELECT MIN(reg_date) FROM course_selections_2017 WHERE reg_date IS NOT NULL))
                                    / (SELECT COUNT(*) FROM course_selections_2017 WHERE reg_date IS NOT NULL);
    CURSOR cur_2018 IS 
        SELECT DISTINCT c.ders_kod, c.year, c.term, s.emp_id, s.type FROM course_selections_2018 c, course_sections s WHERE c.ders_kod = s.ders_kod 
                                    AND c.year = s.year AND s.term = c.term AND reg_date IS NOT NULL AND s.type = p_type AND c.term = p_term
                                    ORDER BY ((SELECT MAX(reg_date) FROM course_selections_2018 WHERE reg_date IS NOT NULL) 
                                    - (SELECT MIN(reg_date) FROM course_selections_2018 WHERE reg_date IS NOT NULL))
                                    / (SELECT COUNT(*) FROM course_selections_2018 WHERE reg_date IS NOT NULL);
    CURSOR cur_2019 IS 
        SELECT DISTINCT c.ders_kod, c.year, c.term, s.emp_id, s.type FROM course_selections_2019 c, course_sections s WHERE c.ders_kod = s.ders_kod 
                                    AND c.year = s.year AND s.term = c.term AND reg_date IS NOT NULL AND s.type = p_type AND c.term = p_term
                                    ORDER BY ((SELECT MAX(reg_date) FROM course_selections_2019 WHERE reg_date IS NOT NULL) 
                                    - (SELECT MIN(reg_date) FROM course_selections_2019 WHERE reg_date IS NOT NULL))
                                    / (SELECT COUNT(*) FROM course_selections_2019 WHERE reg_date IS NOT NULL);        
    v_ders_kod VARCHAR2(10);
    v_year NUMBER(4);
    v_term NUMBER(1);
    v_emp_id NUMBER(10);
    v_type VARCHAR2(1);
BEGIN
    IF p_year = 2016 THEN 
        OPEN cur_2016;
        LOOP
            FETCH cur_2016 INTO v_ders_kod, v_year, v_term, v_emp_id, v_type;
            EXIT WHEN cur_2016%NOTFOUND;
            IF v_emp_id IS NOT NULL THEN
                DBMS_OUTPUT.PUT_LINE(v_ders_kod || '  ' || v_emp_id || '  ' || v_type);
            ELSE
                DBMS_OUTPUT.PUT_LINE(v_ders_kod || '         ' || v_type);                
            END IF;
        END LOOP;
        CLOSE cur_2016;
    ELSIF p_year = 2017 THEN 
        OPEN cur_2017;
        LOOP
            FETCH cur_2017 INTO v_ders_kod, v_year, v_term, v_emp_id, v_type;
            EXIT WHEN cur_2017%NOTFOUND;
            IF v_emp_id IS NOT NULL THEN
                DBMS_OUTPUT.PUT_LINE(v_ders_kod || '  ' || v_emp_id || '  ' || v_type);
            ELSE
                DBMS_OUTPUT.PUT_LINE(v_ders_kod || '         ' || v_type);                
            END IF;
        END LOOP;
        CLOSE cur_2017;
    ELSIF p_year = 2018 THEN 
        OPEN cur_2018;
        LOOP
            FETCH cur_2018 INTO v_ders_kod, v_year, v_term, v_emp_id, v_type;
            EXIT WHEN cur_2018%NOTFOUND;
            IF v_emp_id IS NOT NULL THEN
                DBMS_OUTPUT.PUT_LINE(v_ders_kod || '  ' || v_emp_id || '  ' || v_type);
            ELSE
                DBMS_OUTPUT.PUT_LINE(v_ders_kod || '         ' || v_type);                
            END IF;
        END LOOP;
        CLOSE cur_2018;
    ELSIF p_year = 2019 THEN 
        OPEN cur_2019;
        LOOP
            FETCH cur_2019 INTO v_ders_kod, v_year, v_term, v_emp_id, v_type;
            EXIT WHEN cur_2019%NOTFOUND;
            IF v_emp_id IS NOT NULL THEN
                DBMS_OUTPUT.PUT_LINE(v_ders_kod || '  ' || v_emp_id || '  ' || v_type);
            ELSE
                DBMS_OUTPUT.PUT_LINE(v_ders_kod || '         ' || v_type);                
            END IF;
        END LOOP;
        CLOSE cur_2019;
    END IF;
END;

EXECUTE proc_popular_teacher(2016, 3, 'P');

-- 3. –ассчитайте средний балл студента за семестр и всего
-- GPA = Sum of (Point * Credit) / Sum of Credits
CREATE OR REPLACE PACKAGE gpa AS
    FUNCTION func_point(p_grade IN NUMBER) RETURN FLOAT;
    
    PROCEDURE proc_gpa (p_stud_id VARCHAR2 , p_year NUMBER);
    
    PROCEDURE proc_spa (p_stud_id VARCHAR2 , p_year NUMBER, p_term NUMBER);
END gpa;

CREATE OR REPLACE PACKAGE BODY gpa AS
    FUNCTION func_point( p_grade IN NUMBER )
    RETURN FLOAT
    IS   
        v_point FLOAT;
    BEGIN
        IF p_grade BETWEEN 95 AND 100 THEN
            v_point := 4.00;
        ELSIF p_grade BETWEEN 90 AND 94 THEN
            v_point := 3.67;
        ELSIF p_grade BETWEEN 85 AND 89 THEN
            v_point := 3.33;
        ELSIF p_grade BETWEEN 80 AND 84 THEN
            v_point := 3.00;
        ELSIF p_grade BETWEEN 75 AND 79 THEN
            v_point := 2.67;
        ELSIF p_grade BETWEEN 70 AND 74 THEN
            v_point := 2.33;
        ELSIF p_grade BETWEEN 65 AND 69 THEN
            v_point := 2.00;
        ELSIF p_grade BETWEEN 60 AND 64 THEN
            v_point := 1.67;
        ELSIF p_grade BETWEEN 55 AND 59 THEN
            v_point := 1.33;
        ELSIF p_grade BETWEEN 50 AND 54 THEN
            v_point := 1.00;
        ELSE
            v_point := 0.00;
        END IF;
        RETURN v_point;
    END func_point;
    
    PROCEDURE proc_gpa (p_stud_id VARCHAR2 , p_year NUMBER) IS
        CURSOR cur_2016 IS
            SELECT DISTINCT c.qiymet_yuz, s.credits FROM course_selections_2016 c, course_sections s WHERE c.ders_kod = s.ders_kod
                                                                AND c.year = s.year
                                                                AND c.term = s.term
                                                                AND c.stud_id = p_stud_id; 
        CURSOR cur_2017 IS
            SELECT DISTINCT c.qiymet_yuz, s.credits FROM course_selections_2017 c, course_sections s WHERE c.ders_kod = s.ders_kod
                                                                AND c.year = s.year
                                                                AND c.term = s.term
                                                                AND c.stud_id = p_stud_id;    
        CURSOR cur_2018 IS
            SELECT DISTINCT c.qiymet_yuz, s.credits FROM course_selections_2018 c, course_sections s WHERE c.ders_kod = s.ders_kod
                                                                AND c.year = s.year
                                                                AND c.term = s.term
                                                                AND c.stud_id = p_stud_id;
        CURSOR cur_2019 IS
            SELECT DISTINCT c.qiymet_yuz, s.credits FROM course_selections_2019 c, course_sections s WHERE c.ders_kod = s.ders_kod
                                                                AND c.year = s.year
                                                                AND c.term = s.term
                                                                AND c.stud_id = p_stud_id;
        v_qiymet_yuz NUMBER(10);
        v_credits NUMBER(10);
        v_sumOfPointCredit NUMBER(10) := 0;
        v_sumOfCredits NUMBER(10) := 0;
    BEGIN
        IF p_year = 2016 THEN 
            OPEN cur_2016;
            LOOP
                FETCH cur_2016 INTO v_qiymet_yuz, v_credits;
                EXIT WHEN cur_2016%NOTFOUND;
                v_sumOfPointCredit := v_sumOfPointCredit  + (func_point(v_qiymet_yuz) * v_credits);
                v_sumOfCredits := v_sumOfCredits + v_credits;
            END LOOP;
            CLOSE cur_2016;
            DBMS_OUTPUT.PUT_LINE('ID: ' || p_stud_id);
            IF (v_sumOfPointCredit = 0 OR v_sumOfCredits = 0) THEN
                DBMS_OUTPUT.PUT_LINE('This student is empty this semester.');
            ELSE
                DBMS_OUTPUT.PUT_LINE('GPA: ' || ROUND(v_sumOfPointCredit / v_sumOfCredits, 2));
            END IF;
        ELSIF p_year = 2017 THEN 
            OPEN cur_2017;
            LOOP
                FETCH cur_2017 INTO v_qiymet_yuz, v_credits;
                EXIT WHEN cur_2017%NOTFOUND;
                v_sumOfPointCredit := v_sumOfPointCredit  + (func_point(v_qiymet_yuz) * v_credits);
                v_sumOfCredits := v_sumOfCredits + v_credits;
            END LOOP;
            CLOSE cur_2017;
            DBMS_OUTPUT.PUT_LINE('ID: ' || p_stud_id);
            IF (v_sumOfPointCredit = 0 OR v_sumOfCredits = 0) THEN
                DBMS_OUTPUT.PUT_LINE('This student is empty this semester.');
            ELSE
                DBMS_OUTPUT.PUT_LINE('GPA: ' || ROUND(v_sumOfPointCredit / v_sumOfCredits, 2));
            END IF;
        ELSIF p_year = 2018 THEN 
            OPEN cur_2018;
            LOOP
                FETCH cur_2018 INTO v_qiymet_yuz, v_credits;
                EXIT WHEN cur_2018%NOTFOUND;
                v_sumOfPointCredit := v_sumOfPointCredit  + (func_point(v_qiymet_yuz) * v_credits);
                v_sumOfCredits := v_sumOfCredits + v_credits;
            END LOOP;
            CLOSE cur_2018;
            DBMS_OUTPUT.PUT_LINE('ID: ' || p_stud_id);
            IF (v_sumOfPointCredit = 0 OR v_sumOfCredits = 0) THEN
                DBMS_OUTPUT.PUT_LINE('This student is empty this semester.');
            ELSE
                DBMS_OUTPUT.PUT_LINE('GPA: ' || ROUND(v_sumOfPointCredit / v_sumOfCredits, 2));
            END IF;
        ELSIF p_year = 2019 THEN 
            OPEN cur_2019;
            LOOP
                FETCH cur_2019 INTO v_qiymet_yuz, v_credits;
                EXIT WHEN cur_2019%NOTFOUND;
                v_sumOfPointCredit := v_sumOfPointCredit  + (func_point(v_qiymet_yuz) * v_credits);
                v_sumOfCredits := v_sumOfCredits + v_credits;
            END LOOP;
            CLOSE cur_2019;
            DBMS_OUTPUT.PUT_LINE('ID: ' || p_stud_id);
            IF (v_sumOfPointCredit = 0 OR v_sumOfCredits = 0) THEN
                DBMS_OUTPUT.PUT_LINE('This student is empty this semester.');
            ELSE
                DBMS_OUTPUT.PUT_LINE('GPA: ' || ROUND(v_sumOfPointCredit / v_sumOfCredits, 2));
            END IF;
        ELSE
            DBMS_OUTPUT.PUT_LINE('Such a year of study does not exist in the database');
        END IF;
    END;
    
    PROCEDURE proc_spa (p_stud_id VARCHAR2 , p_year NUMBER, p_term NUMBER) IS
        CURSOR cur_2016 IS
            SELECT DISTINCT c.term, c.qiymet_yuz, s.credits FROM course_selections_2016 c, course_sections s WHERE c.ders_kod = s.ders_kod
                                                                AND c.year = s.year
                                                                AND c.term = s.term
                                                                AND c.stud_id = p_stud_id
                                                                AND c.term = p_term; 
        CURSOR cur_2017 IS
            SELECT DISTINCT c.term, c.qiymet_yuz, s.credits FROM course_selections_2017 c, course_sections s WHERE c.ders_kod = s.ders_kod
                                                                AND c.year = s.year
                                                                AND c.term = s.term
                                                                AND c.stud_id = p_stud_id
                                                                AND c.term = p_term;    
        CURSOR cur_2018 IS
            SELECT DISTINCT c.term, c.qiymet_yuz, s.credits FROM course_selections_2018 c, course_sections s WHERE c.ders_kod = s.ders_kod
                                                                AND c.year = s.year
                                                                AND c.term = s.term
                                                                AND c.stud_id = p_stud_id;
        CURSOR cur_2019 IS
            SELECT DISTINCT c.term, c.qiymet_yuz, s.credits FROM course_selections_2019 c, course_sections s WHERE c.ders_kod = s.ders_kod
                                                                AND c.year = s.year
                                                                AND c.term = s.term
                                                                AND c.stud_id = p_stud_id
                                                                AND c.term = p_term;
        v_term NUMBER(10);
        v_qiymet_yuz NUMBER(10);
        v_credits NUMBER(10);
        v_sumOfPointCredit NUMBER(10) := 0;
        v_sumOfCredits NUMBER(10) := 0;
    BEGIN
        IF p_year = 2016 THEN 
            OPEN cur_2016;
            LOOP
                FETCH cur_2016 INTO v_term, v_qiymet_yuz, v_credits;
                EXIT WHEN cur_2016%NOTFOUND;
                v_sumOfPointCredit := v_sumOfPointCredit  + (func_point(v_qiymet_yuz) * v_credits);
                v_sumOfCredits := v_sumOfCredits + v_credits;
            END LOOP;
            CLOSE cur_2016;
            DBMS_OUTPUT.PUT_LINE('ID: ' || p_stud_id);
            IF (v_sumOfPointCredit = 0 OR v_sumOfCredits = 0) THEN
                DBMS_OUTPUT.PUT_LINE('This student is empty this semester.');
            ELSE
                DBMS_OUTPUT.PUT_LINE('GPA: ' || ROUND(v_sumOfPointCredit / v_sumOfCredits, 2));
            END IF;
        ELSIF p_year = 2017 THEN 
            OPEN cur_2017;
            LOOP
                FETCH cur_2017 INTO v_term, v_qiymet_yuz, v_credits;
                EXIT WHEN cur_2017%NOTFOUND;
                v_sumOfPointCredit := v_sumOfPointCredit  + (func_point(v_qiymet_yuz) * v_credits);
                v_sumOfCredits := v_sumOfCredits + v_credits;
            END LOOP;
            CLOSE cur_2017;
            DBMS_OUTPUT.PUT_LINE('ID: ' || p_stud_id);
            IF (v_sumOfPointCredit = 0 OR v_sumOfCredits = 0) THEN
                DBMS_OUTPUT.PUT_LINE('This student is empty this semester.');
            ELSE
                DBMS_OUTPUT.PUT_LINE('GPA: ' || ROUND(v_sumOfPointCredit / v_sumOfCredits, 2));
            END IF;
        ELSIF p_year = 2018 THEN 
            OPEN cur_2018;
            LOOP
                FETCH cur_2018 INTO v_term, v_qiymet_yuz, v_credits;
                EXIT WHEN cur_2018%NOTFOUND;
                v_sumOfPointCredit := v_sumOfPointCredit  + (func_point(v_qiymet_yuz) * v_credits);
                v_sumOfCredits := v_sumOfCredits + v_credits;
            END LOOP;
            CLOSE cur_2018;
            DBMS_OUTPUT.PUT_LINE('ID: ' || p_stud_id);
            IF (v_sumOfPointCredit = 0 OR v_sumOfCredits = 0) THEN
                DBMS_OUTPUT.PUT_LINE('This student is empty this semester.');
            ELSE
                DBMS_OUTPUT.PUT_LINE('GPA: ' || ROUND(v_sumOfPointCredit / v_sumOfCredits, 2));
            END IF;
        ELSIF p_year = 2019 THEN 
            OPEN cur_2019;
            LOOP
                FETCH cur_2019 INTO v_term, v_qiymet_yuz, v_credits;
                EXIT WHEN cur_2019%NOTFOUND;
                v_sumOfPointCredit := v_sumOfPointCredit  + (func_point(v_qiymet_yuz) * v_credits);
                v_sumOfCredits := v_sumOfCredits + v_credits;
            END LOOP;
            CLOSE cur_2019;
            DBMS_OUTPUT.PUT_LINE('ID: ' || p_stud_id);
            IF (v_sumOfPointCredit = 0 OR v_sumOfCredits = 0) THEN
                DBMS_OUTPUT.PUT_LINE('This student is empty this semester.');
            ELSE
                DBMS_OUTPUT.PUT_LINE('GPA: ' || ROUND(v_sumOfPointCredit / v_sumOfCredits, 2));
            END IF;
        ELSE
            DBMS_OUTPUT.PUT_LINE('Such a year of study does not exist in the database');
        END IF;
    END;        
END gpa;

BEGIN
    gpa.proc_gpa('DC767F8AD986E8CE5319552F0E4613DBB43BC24A', 2016);
    gpa.proc_spa('DC767F8AD986E8CE5319552F0E4613DBB43BC24A', 2016, 1);
END;

-- 4. Ќайдите студентов, которые не зарегистрировали никаких предметов в течение одного семестра
CREATE OR REPLACE PROCEDURE proc_didnt_register (p_year NUMBER, p_term NUMBER) IS
    CURSOR cur_no_reg_2016 IS
        SELECT * FROM course_selections_2016 WHERE reg_date IS NULL AND year = p_year AND term = p_term;
    didnt_reg_rec_2016 cur_no_reg_2016%ROWTYPE;
    
    CURSOR cur_no_reg_2017 IS
        SELECT * FROM course_selections_2017 WHERE reg_date IS NULL AND year = p_year AND term = p_term;
    didnt_reg_rec_2017 cur_no_reg_2017%ROWTYPE;
    
    CURSOR cur_no_reg_2018 IS
        SELECT * FROM course_selections_2018 WHERE reg_date IS NULL AND year = p_year AND term = p_term;
    didnt_reg_rec_2018 cur_no_reg_2018%ROWTYPE;
    
    CURSOR cur_no_reg_2019 IS
        SELECT * FROM course_selections_2019 WHERE reg_date IS NULL AND year = p_year AND term = p_term;
    didnt_reg_rec_2019 cur_no_reg_2019%ROWTYPE;
    
    v_count NUMBER(10) := 0;
BEGIN
    IF p_year = 2016 THEN
        OPEN cur_no_reg_2016;
        LOOP
            FETCH cur_no_reg_2016 INTO didnt_reg_rec_2016;
            v_count := v_count + 1;
            EXIT WHEN v_count = 100;
            DBMS_OUTPUT.PUT_LINE(didnt_reg_rec_2016.stud_id || ' ' || didnt_reg_rec_2016.year || ' ' || didnt_reg_rec_2016.term);
        END LOOP;
        CLOSE cur_no_reg_2016;
    ELSIF p_year = 2017 THEN
        OPEN cur_no_reg_2017;
        LOOP
            FETCH cur_no_reg_2017 INTO didnt_reg_rec_2017;
            v_count := v_count + 1;
            EXIT WHEN v_count = 100;
            DBMS_OUTPUT.PUT_LINE(didnt_reg_rec_2017.stud_id || ' ' || didnt_reg_rec_2017.year || ' ' || didnt_reg_rec_2017.term);
        END LOOP;
        CLOSE cur_no_reg_2017;
    ELSIF p_year = 2018 THEN
        OPEN cur_no_reg_2018;
        LOOP
            FETCH cur_no_reg_2018 INTO didnt_reg_rec_2018;
            v_count := v_count + 1;
            EXIT WHEN v_count = 100;
            DBMS_OUTPUT.PUT_LINE(didnt_reg_rec_2018.stud_id || ' ' || didnt_reg_rec_2018.year || ' ' || didnt_reg_rec_2018.term);
        END LOOP;
        CLOSE cur_no_reg_2018;
    ELSIF p_year = 2019 THEN
        OPEN cur_no_reg_2019;
        LOOP
            FETCH cur_no_reg_2019 INTO didnt_reg_rec_2019;
            v_count := v_count + 1;
            EXIT WHEN v_count = 100;
            DBMS_OUTPUT.PUT_LINE(didnt_reg_rec_2019.stud_id || ' ' || didnt_reg_rec_2019.year || ' ' || didnt_reg_rec_2019.term);
        END LOOP;
        CLOSE cur_no_reg_2019;
    ELSE 
        DBMS_OUTPUT.PUT_LINE('Sorry.... This year does not exist in the database');
    END IF;
END;

EXECUTE proc_didnt_register(2017, 2);

-- 5. ѕодсчитайте, сколько денег студент потратил на повторы за данный семестр (включительно) и общую сумму потраченных средств.
CREATE OR REPLACE PROCEDURE student_retakes (p_stud_id VARCHAR2, p_year NUMBER) IS
    TYPE retake IS TABLE OF NUMBER INDEX BY PLS_INTEGER;
    retake_list retake;
BEGIN
    IF p_year = 2016 THEN
        SELECT COUNT(*) INTO retake_list(1) FROM course_selections_2016 WHERE qiymet_herf = 'F' AND stud_id = p_stud_id AND term = 1;
        SELECT COUNT(*) INTO retake_list(2) FROM course_selections_2016 WHERE qiymet_herf = 'F' AND stud_id = p_stud_id AND term = 2;
        SELECT COUNT(*) INTO retake_list(3) FROM course_selections_2016 WHERE qiymet_herf = 'F' AND stud_id = p_stud_id AND term = 3;
        SELECT COUNT(*) INTO retake_list(4) FROM course_selections_2016 WHERE qiymet_herf = 'F' AND stud_id = p_stud_id;
        DBMS_OUTPUT.PUT_LINE('Term 1: ' || retake_list(1) || ' retakes, To pay: ' || retake_list(1) * 25000);
        DBMS_OUTPUT.PUT_LINE('Term 2: ' || retake_list(2) || ' retakes, To pay: ' || retake_list(2) * 25000);
        DBMS_OUTPUT.PUT_LINE('Term 3: ' || retake_list(3) || ' retakes, To pay: ' || retake_list(3) * 25000);
        DBMS_OUTPUT.PUT_LINE('All:    ' || retake_list(4) || ' retakes, To pay: ' || retake_list(4) * 25000);
    ELSIF p_year = 2017 THEN
        SELECT COUNT(*) INTO retake_list(1) FROM course_selections_2017 WHERE qiymet_herf = 'F' AND stud_id = p_stud_id AND term = 1;
        SELECT COUNT(*) INTO retake_list(2) FROM course_selections_2017 WHERE qiymet_herf = 'F' AND stud_id = p_stud_id AND term = 2;
        SELECT COUNT(*) INTO retake_list(3) FROM course_selections_2017 WHERE qiymet_herf = 'F' AND stud_id = p_stud_id AND term = 3;
        SELECT COUNT(*) INTO retake_list(4) FROM course_selections_2017 WHERE qiymet_herf = 'F' AND stud_id = p_stud_id;
        DBMS_OUTPUT.PUT_LINE('Term 1: ' || retake_list(1) || ' retakes, To pay: ' || retake_list(1) * 25000);
        DBMS_OUTPUT.PUT_LINE('Term 2: ' || retake_list(2) || ' retakes, To pay: ' || retake_list(2) * 25000);
        DBMS_OUTPUT.PUT_LINE('Term 3: ' || retake_list(3) || ' retakes, To pay: ' || retake_list(3) * 25000);
        DBMS_OUTPUT.PUT_LINE('All:    ' || retake_list(4) || ' retakes, To pay: ' || retake_list(4) * 25000);
    ELSIF p_year = 2018 THEN
        SELECT COUNT(*) INTO retake_list(1) FROM course_selections_2018 WHERE qiymet_herf = 'F' AND stud_id = p_stud_id AND term = 1;
        SELECT COUNT(*) INTO retake_list(2) FROM course_selections_2018 WHERE qiymet_herf = 'F' AND stud_id = p_stud_id AND term = 2;
        SELECT COUNT(*) INTO retake_list(3) FROM course_selections_2018 WHERE qiymet_herf = 'F' AND stud_id = p_stud_id AND term = 3;
        SELECT COUNT(*) INTO retake_list(4) FROM course_selections_2018 WHERE qiymet_herf = 'F' AND stud_id = p_stud_id;
        DBMS_OUTPUT.PUT_LINE('Term 1: ' || retake_list(1) || ' retakes, To pay: ' || retake_list(1) * 25000);
        DBMS_OUTPUT.PUT_LINE('Term 2: ' || retake_list(2) || ' retakes, To pay: ' || retake_list(2) * 25000);
        DBMS_OUTPUT.PUT_LINE('Term 3: ' || retake_list(3) || ' retakes, To pay: ' || retake_list(3) * 25000);
        DBMS_OUTPUT.PUT_LINE('All:    ' || retake_list(4) || ' retakes, To pay: ' || retake_list(4) * 25000);
    ELSIF p_year = 2019 THEN
        SELECT COUNT(*) INTO retake_list(1) FROM course_selections_2019 WHERE qiymet_herf = 'F' AND stud_id = p_stud_id AND term = 1;
        SELECT COUNT(*) INTO retake_list(2) FROM course_selections_2019 WHERE qiymet_herf = 'F' AND stud_id = p_stud_id AND term = 2;
        SELECT COUNT(*) INTO retake_list(3) FROM course_selections_2019 WHERE qiymet_herf = 'F' AND stud_id = p_stud_id AND term = 3;
        SELECT COUNT(*) INTO retake_list(4) FROM course_selections_2019 WHERE qiymet_herf = 'F' AND stud_id = p_stud_id;
        DBMS_OUTPUT.PUT_LINE('Term 1: ' || retake_list(1) || ' retakes, To pay: ' || retake_list(1) * 25000);
        DBMS_OUTPUT.PUT_LINE('Term 2: ' || retake_list(2) || ' retakes, To pay: ' || retake_list(2) * 25000);
        DBMS_OUTPUT.PUT_LINE('Term 3: ' || retake_list(3) || ' retakes, To pay: ' || retake_list(3) * 25000);
        DBMS_OUTPUT.PUT_LINE('All:    ' || retake_list(4) || ' retakes, To pay: ' || retake_list(4) * 25000);
    ELSE 
        DBMS_OUTPUT.PUT_LINE('Sorry.... This year does not exist in the database');
    END IF;
END;

SELECT * FROM course_selections_2016 WHERE qiymet_herf = 'F' AND stud_id = '3BBC4622D794491436DDC8B73F3062BF1C4A1FFA';

-- 6. –ассчитайте Ђнагрузкуї учителей (сколько часов у ”чител€ за данный семестр)
-- Mozhno po TYPE: N, L - lecture; P - practice | po year | ASC, DESC
-- Term 1
SELECT emp_id, SUM(hour_num) AS loading FROM course_sections WHERE week_num IS NOT NULL AND term = 1 GROUP BY emp_id ORDER BY loading DESC;

-- Term 2
SELECT emp_id, SUM(hour_num) AS loading FROM course_sections WHERE week_num IS NOT NULL AND term = 2 GROUP BY emp_id ORDER BY loading DESC;

-- Term 3
SELECT emp_id, SUM(hour_num) AS loading FROM course_sections WHERE week_num IS NOT NULL AND term = 3 GROUP BY emp_id ORDER BY loading DESC;

-- 7. —оставить расписание преподавателей на семестр
-- po year, term, type | order by ASC,DESC
SELECT DISTINCT c.ders_kod, c.year, c.term, c.type, s.start_time FROM course_sections c, course_schedule s WHERE 
                                                        c.ders_kod = s.ders_kod
                                                        AND c.year = s.year
                                                        AND c.term = s.term
                                                        AND c.term = 1 
                                                        AND c.year = 2016 
                                                        AND c.emp_id = 10112
                                                        ORDER BY s.start_time;


-- 8. —оставление расписани€ студента на семестр
-- po year, term, type
SELECT DISTINCT c.ders_kod, c.year, c.term, s.start_time FROM course_selections_2016 c, course_schedule s WHERE 
                                                        c.ders_kod = s.ders_kod
                                                        AND c.year = s.year
                                                        AND c.term = s.term
                                                        AND c.term = 1 
                                                        AND c.year = 2016 
                                                        AND c.stud_id = 'DC767F8AD986E8CE5319552F0E4613DBB43BC24A'
                                                        ORDER BY s.start_time;


-- 9. ѕоказать, сколько предметов и кредитов было выбрано студентом
SELECT DISTINCT c.ders_kod, s.credits FROM course_selections_2016 c, course_sections s WHERE c.ders_kod = s.ders_kod
                                                            AND c.term = s.term
                                                            AND c.stud_id = 'DC767F8AD986E8CE5319552F0E4613DBB43BC24A' AND c.term = 1;


-- 10. Ќайти самый умный поток студентов по среднему рейтингу по одному предмету в один учитель
SELECT ders_kod, practice, AVG(qiymet_yuz) AS average from course_selections_2016 GROUP BY ders_kod, practice ORDER BY average DESC;

-- 11. –ейтинг учителей за семестр (список)
SELECT emp_id, COUNT(*) AS rating FROM course_sections WHERE year = 2016 GROUP BY emp_id ORDER BY rating DESC;

-- 12. “ематические рейтинги за семестр (список)
SELECT ders_kod, COUNT(*) AS rating FROM course_sections WHERE year = 2016 GROUP BY ders_kod ORDER BY rating DESC;

-- 13. –ассчитайте общее количество повторов за все врем€ и отобразите прибыль.
CREATE OR REPLACE PROCEDURE proc_all_retakes IS
    v_retakes_2016 NUMBER(30);
    v_retakes_2017 NUMBER(30);
    v_retakes_2018 NUMBER(30);
    v_retakes_2019 NUMBER(30);

    v_profit_2016 NUMBER(30);
    v_profit_2017 NUMBER(30);
    v_profit_2018 NUMBER(30);
    v_profit_2019 NUMBER(30);
BEGIN
    SELECT COUNT(*) INTO v_retakes_2016 FROM course_selections_2016 WHERE qiymet_herf = 'F';
    SELECT COUNT(*) INTO v_retakes_2017 FROM course_selections_2017 WHERE qiymet_herf = 'F';
    SELECT COUNT(*) INTO v_retakes_2018 FROM course_selections_2018 WHERE qiymet_herf = 'F';
    SELECT COUNT(*) INTO v_retakes_2019 FROM course_selections_2019 WHERE qiymet_herf = 'F';
    
    SELECT SUM(s.credits * 25000) INTO v_profit_2016 FROM course_sections s, course_selections_2016 c WHERE s.ders_kod = c.ders_kod AND c.qiymet_herf = 'F';
    SELECT SUM(s.credits * 25000) INTO v_profit_2017 FROM course_sections s, course_selections_2017 c WHERE s.ders_kod = c.ders_kod AND c.qiymet_herf = 'F';
    SELECT SUM(s.credits * 25000) INTO v_profit_2018 FROM course_sections s, course_selections_2018 c WHERE s.ders_kod = c.ders_kod AND c.qiymet_herf = 'F';
    SELECT SUM(s.credits * 25000) INTO v_profit_2019 FROM course_sections s, course_selections_2019 c WHERE s.ders_kod = c.ders_kod AND c.qiymet_herf = 'F';
    
    DBMS_OUTPUT.PUT_LINE('Retakes 2016: ' || v_retakes_2016 || ', Profit: ' || v_profit_2016);
    DBMS_OUTPUT.PUT_LINE('Retakes 2017: ' || v_retakes_2017 || ', Profit: ' || v_profit_2017);
    DBMS_OUTPUT.PUT_LINE('Retakes 2018: ' || v_retakes_2018 || ', Profit: ' || v_profit_2018);
    DBMS_OUTPUT.PUT_LINE('Retakes 2019: ' || v_retakes_2019 || ', Profit: ' || v_profit_2019);
END;
