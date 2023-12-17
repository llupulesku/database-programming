--hw.2

REM Q1.
DECLARE
 dept_id departments.department_ID%TYPE := 111;
 dept_name departments.department_name%TYPE := 'Fortest';
 dept_managerID departments.manager_id%TYPE := 100;
 dept_locationID departments.location_id%TYPE := 1700;

BEGIN
insert into departments(department_ID, department_name, manager_id, location_id)
VALUES (dept_id, dept_name, dept_managerID, dept_locationID);
DBMS_OUTPUT.PUT_LINE('A new record was inserted into the Departments table: ' || dept_id || ' '|| dept_name || ' ' || dept_managerID || ' ' || dept_locationID);

end;
/

REM Q2.
DECLARE
 dept_id departments.department_ID%TYPE := 111;
 dept_name departments.department_name%TYPE := 'Fortest';
 dept_managerID departments.manager_id%TYPE := 100;
 dept_locationID departments.location_id%TYPE := 1700;

 BEGIN 
 delete from departments where department_ID = dept_id
 returning department_name, manager_id into dept_name, dept_managerID;
 DBMS_OUTPUT.PUT_LINE('The department name and manager ID for the record just deleted are: ' || dept_name || ' ' || dept_managerID);

 end;
 /

 REM Q3.
 DECLARE
 dept_id departments.department_ID%TYPE := 230;
 dept_name departments.department_name%TYPE;
 dept_managerID departments.manager_id%TYPE;
 dept_locationID departments.location_id%TYPE;

 BEGIN 
 update departments set manager_id = 103
 where department_id = dept_id
 returning department_name into dept_name;
 
 DBMS_OUTPUT.PUT_LINE('This is the updated record: ' || dept_name);

end;
/

REM Q4.
DECLARE
dept_id employees.department_id%TYPE := 80;
emp employees.employee_id%TYPE;
dept_size varchar2(20);

BEGIN
select count(employees.employee_id)into emp from employees
where department_id = dept_id;
DBMS_OUTPUT.PUT_LINE(emp);

case
when emp >= 30 then dept_size:= 'LARGE';
DBMS_OUTPUT.PUT_LINE(dept_size);
when emp > 8  or emp <= 29 then dept_size:= 'MEDIUM';
DBMS_OUTPUT.PUT_LINE(dept_size);
when emp <= 7  then dept_size:= 'SMALL';
DBMS_OUTPUT.PUT_LINE(dept_size);
end case;

end;
/


REM Q5. 

Column  salary format $99,999
SELECT 	employee_id, salary, 
		floor (months_between (sysdate, hire_date)/12) Years
FROM 	employees 
where employee_id in ( 128, 192, 206);

DECLARE
emp_ID employees.employee_id%TYPE := 206;
emp_salary employees.salary%TYPE;
workDate employees.hire_date%TYPE;
yrs number;
wYears number := floor(months_between (sysdate, workDate)/12);
baseBonus number := 1000;
n number;
sal number;

Begin 
select employee_id, salary, hire_date, floor(months_between (sysdate, hire_date)/12) yrs 
into emp_ID, emp_salary, workDate, wYears 
from EMPLOYEES
where employee_id = emp_ID;

DBMS_OUTPUT.PUT_LINE('The employee ID is ' || emp_ID || '.' || ' The salary is ' || emp_salary || '.' || ' The working years are ' || wYears);
if(emp_salary > 10000)then 
sal := 1100;
    if (wYears < 25) then
        n := emp_salary + 1000 + sal ;
        DBMS_OUTPUT.PUT_LINE('Total: ' || n);
    elsif (wYears >= 25 and wYears < 27) then
        n := emp_salary + 500 + sal + baseBonus;
        DBMS_OUTPUT.PUT_LINE('Total: ' || n);
    elsif (wYears >= 27) then
        n := emp_salary + 700 + sal + baseBonus;
        DBMS_OUTPUT.PUT_LINE('Total: ' || n);
    end if;
elsif (emp_salary >= 5000 and emp_salary <= 10000) then 
    sal := 1000;
    if (wYears < 25) then
        n := emp_salary + 1000 + sal;
        DBMS_OUTPUT.PUT_LINE('Total: ' || n);
    elsif (wYears >= 25 and wYears < 27) then
        n := emp_salary + 500 + sal + baseBonus;
        DBMS_OUTPUT.PUT_LINE('Total: ' || n);
    elsif (wYears >= 27) then
        n := emp_salary + 700 + sal + baseBonus;
        DBMS_OUTPUT.PUT_LINE('Total: ' || n);
    end if;
elsif(emp_salary < 5000) then 
    sal := 900;
    if (wYears < 25) then
        n := emp_salary + 1000 + sal;
        DBMS_OUTPUT.PUT_LINE('Total: ' || n);
    elsif (wYears >= 25 and wYears < 27) then
        n := emp_salary + 500 + sal + baseBonus;
        DBMS_OUTPUT.PUT_LINE('Total: ' || n);
    elsif (wYears >= 27) then
        n := emp_salary + 700 + sal + baseBonus;
        DBMS_OUTPUT.PUT_LINE('Total: ' || n);
    end if;
    end if;
    end;
    /



   REM Q6.
    DECLARE
    num number := 15;

    BEGIN
    DBMS_OUTPUT.PUT_LINE('This is a basic loop');
    LOOP
    DBMS_OUTPUT.PUT_LINE('Inside the loop: ' || TO_CHAR(num));
    num := num + 1;
    IF num >= 18 THEN
    EXIT;
    END IF; 
    END LOOP;

    end;
    /

    DECLARE

    BEGIN 
    DBMS_OUTPUT.PUT_LINE('This is a For loop');
    for i in 15 ..17 loop
        DBMS_OUTPUT.PUT_LINE('Inside the loop: ' || TO_CHAR(i));
    end loop;
    end;
    /

    DECLARE
    num number := 15;

    BEGIN
    DBMS_OUTPUT.PUT_LINE('This is a While loop');
    while(num < 18 ) loop
        DBMS_OUTPUT.PUT_LINE('Inside the loop: ' || TO_CHAR(num));
        num := num + 1;
    end loop;
    end;
    /


REM Q7.
DECLARE
   i    integer := 1 ;
   j    integer := 1 ;
BEGIN
   
     while( i <= 10) loop
        dbms_output.put_line('|');
        dbms_output.put('| ');
     while(i<= 10) loop
        dbms_output.put ( ' ' || (TO_CHAR ( i*10 + j )) || ' ' ) ;
        exit when j = 9 ;
        j := j + 1 ; 
      END LOOP;                     
      j := 1;
      i := i + 1;
      Exit when i > 10 ;   
   END loop;
END;
/



 REM Q8.
CREATE TABLE EMP_TEST as select * from employees 
    where department_id in (20, 30, 60);
  -- SELECT * from EMP_TEST; -- to check if that works, 
  
DECLARE
    
BEGIN 
UPDATE EMP_TEST
SET salary = salary * 1.1
where department_ID = 30 and salary <= 3000;
DBMS_OUTPUT.PUT_LINE('UPDATE: ' || TO_CHAR(SQL%ROWCOUNT));

DELETE FROM EMP_TEST where department_id = 20;

end;
/


REM Q9. 
DECLARE 
emp_ID employees.employee_id%TYPE;
firstName employees.first_name%TYPE;
lastName employees.last_name%TYPE;
dept_id employees.department_ID%TYPE := 30;
fullName varchar(80);
cursor empPtr is select employee_id, (last_name ||' '|| first_name )as fullName
from EMPLOYEES
where department_id =dept_id ;

BEGIN
open empPtr;
loop
fetch empPtr into emp_ID, fullName;
if empPtr%found then 
    DBMS_OUTPUT.PUT_LINE(emp_ID ||' '|| fullName);
else
    exit;
end if;
end loop;
close empPtr;
end;
/










    





    














