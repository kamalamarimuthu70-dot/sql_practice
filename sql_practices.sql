use sql_project;


CREATE TABLE Students (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    age INT,
    marks INT,
    city VARCHAR(50)
);

INSERT INTO Students
VALUES
(1, 'Arun', 20, 85, 'Chennai'),
(2, 'Priya', 19, 78, 'Delhi'),
(3, 'Anitha', 21, 92, 'Chennai'),
(4, 'Rahul', 18, 65, 'Mumbai'),
(5, 'Ajay', 22, 55, 'Delhi'),
(6, 'Sneha', 20, 88, 'Bangalore'),
(7, 'Akash', 19, 75, 'Chennai');

SELECT * FROM Students;

SELECT name, marks
FROM Students;

SELECT *
FROM Students
WHERE marks > 80;

SELECT *
FROM Students
WHERE city = 'Chennai';

SELECT *
FROM Students
WHERE age > 18;

SELECT *
FROM Students
WHERE marks BETWEEN 60 AND 80;

SELECT *
FROM Students
WHERE name LIKE 'A%';

SELECT *
FROM Students
WHERE city <> 'Delhi';

SELECT *
FROM Students
ORDER BY marks DESC;

SELECT *
FROM Students
ORDER BY marks DESC
LIMIT 5;

SELECT COUNT(*) AS Total_Students
FROM Students;

SELECT AVG(marks) AS Average_Marks
FROM Students;

SELECT MAX(marks) AS Maximum_Marks
FROM Students;

SELECT MIN(marks) AS Minimum_Marks
FROM Students;

SELECT SUM(marks) AS Total_Marks
FROM Students;

SELECT city, COUNT(*) AS Number_of_Students
FROM Students
GROUP BY city;

SELECT city, AVG(marks) AS Average_Marks
FROM Students
GROUP BY city;

CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    order_date DATE,
    amount DECIMAL(10,2)
);

INSERT INTO Orders
VALUES
(101,'Arun','2024-01-10',1500.00),
(102,'Priya','2024-03-15',2500.00),
(103,'Rahul','2024-07-20',1800.00),
(104,'Anitha',CURDATE(),3000.00),
(105,'Akash',DATE_SUB(CURDATE(),INTERVAL 5 DAY),2200.00);

SELECT *
FROM Orders
WHERE order_date = CURDATE();

SELECT *
FROM Orders
WHERE order_date >= CURDATE() - INTERVAL 7 DAY;

SELECT *
FROM Orders
WHERE YEAR(order_date) = 2024;

SELECT DATEDIFF('2024-12-31','2024-12-01') AS Days_Difference;

SELECT YEAR(order_date) AS Order_Year
FROM Orders;

SELECT MONTH(order_date) AS Order_Month
FROM Orders;

drop table orders;
drop table customers;
CREATE TABLE Customers (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    city VARCHAR(50)
);

CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    amount DECIMAL(10,2),
    FOREIGN KEY (customer_id) REFERENCES Customers(id)
);

INSERT INTO Customers
VALUES
(1,'Arun','Chennai'),
(2,'Priya','Delhi'),
(3,'Rahul','Mumbai'),
(4,'Anitha','Coimbatore');

INSERT INTO Orders
VALUES
(101,1,1500.00),
(102,2,2500.00),
(103,1,3000.00),
(104,3,1800.00);

SELECT Customers.name, Orders.amount
FROM Customers
INNER JOIN Orders
ON Customers.id = Orders.customer_id;

SELECT Customers.name, Orders.amount
FROM Customers
LEFT JOIN Orders
ON Customers.id = Orders.customer_id;

SELECT Customers.name
FROM Customers
INNER JOIN Orders
ON Customers.id = Orders.customer_id;

SELECT Customers.name
FROM Customers
LEFT JOIN Orders
ON Customers.id = Orders.customer_id
WHERE Orders.customer_id IS NULL;

SELECT Customers.name, SUM(Orders.amount) AS Total_Amount
FROM Customers
INNER JOIN Orders
ON Customers.id = Orders.customer_id
GROUP BY Customers.name;


create table Doctor(
doctor_id int primary key,
doctor_name varchar(50),
spec varchar(50)
);

insert into Doctor values(101,"John","Cardiology"),
(102,"Emma","Neurology"),
(103,"David","Orthopedics"),
(104,"Sarah","Pediatrics");

select *  from Doctor;

create table Patient(
patient_id int primary key,
patient_name varchar(50),
age int
);

insert into Patient values(201,"Alice",30),
(202,"Bob",45),
(203,"Charlie",25),
(204,"Diana",25),
(205,"Ethan",60);

select * from Patient;

create table Appointment(
appointment_id int primary key,
patient_id int,
doctor_id int,
appointment_date date,
foreign key (patient_id)references Patient(patient_id),
foreign key (doctor_id) references Doctor(doctor_id)
);

insert into Appointment values(1,201,101,"2026-07-10"),
(2,202,102,"2026-07-11"),
(3,203,101,"2026-07-12"),
(4,205,103,"2026-07-13");

create table Prescription(
prescription_id int primary key,
appointment_id int,
medicine varchar(50)
);

insert into Prescription values(1,1,"Aspirin"),
(2,2,"Paracetamol"),
(3,4,"Calcium");

select * from Prescription;


select p.patient_name,d.doctor_name from Patient p 
inner join Appointment a on a.patient_id=p.patient_id
inner join Doctor d on a.doctor_id=d.doctor_id;

select p.patient_name,d.spec ,a.appointment_date from Patient p 
inner join Appointment a on a.patient_id=p.patient_id
inner join Doctor d on a.doctor_id=d.doctor_id;

select p.patient_name,d.spec ,a.appointment_date,r.medicine from Patient p 
inner join Appointment a on a.patient_id=p.patient_id
inner join Doctor d on a.doctor_id=d.doctor_id
inner join Prescription r on r.appointment_id=a.appointment_id;

select p.patient_name,d.doctor_name,a.appointment_date from Patient p 
inner join Appointment a on a.patient_id=p.patient_id
inner join Doctor d on a.doctor_id=d.doctor_id;


select p.patient_name,a.appointment_date from Patient p 
left join Appointment a on a.patient_id=p.patient_id;

select a.appointment_date,r.medicine from Appointment a
left join Prescription r on r.appointment_id=a.appointment_id;

select d.doctor_name,p.patient_name from Doctor d
left join Appointment a on d.doctor_id=a.doctor_id
left join Patient P on a.patient_id =p.patient_id;

select p.patient_name,d.doctor_name from Patient p
left join Appointment a on a.patient_id=p.patient_id
left join Doctor d on a.doctor_id=d.doctor_id;

select d.doctor_name,p.patient_name from Appointment a
right join Doctor d on d.doctor_id=a.doctor_id
right join Patient p on p.patient_id=a.patient_id;

select r.medicine,a.appointment_date from Appointment a
right join Prescription r on r.appointment_id=a.appointment_id;

select p.patient_name,d.doctor_name from Patient p
left join Appointment a on a.patient_id=p.patient_id 
left join Doctor d on a.doctor_id=d.doctor_id
union
select p.patient_name,d.doctor_name from Patient p
right join Appointment a on a.patient_id=p.patient_id 
right join Doctor d on a.doctor_id=d.doctor_id;


select d.doctor_name ,count(d.doctor_id)as Highest_appointment from Doctor d
left join Appointment a on a.doctor_id=d.doctor_id
group by d.doctor_id order by Highest_appointment desc limit 1;

select p.patient_name from Patient p
left join Appointment a on p.patient_id = a.patient_id
where a.appointment_id is null;

select a.appointment_id,a.appointment_date from Appointment a
left join Prescription r on a.appointment_id = r.appointment_id
where r.prescription_id is null;

select d.doctor_name from Doctor d
left join Appointment a on d.doctor_id = a.doctor_id
where a.appointment_id is null;

select d.doctor_name from Doctor d
left join Appointment a on d.doctor_id = a.doctor_id
left join Patient p on a.patient_id = p.patient_id
where p.age > 50;

select d.doctor_name,count(a.patient_id) as total_patients from Doctor d 
left join Appointment a on  d.doctor_id = a.doctor_id
group by d.doctor_id, d.doctor_name;

select d.doctor_name,count(a.patient_id) as total_patients from Doctor d
left join Appointment a on d.doctor_id = a.doctor_id
group by d.doctor_id, d.doctor_name
Order by total_patients desc limit 1;

select d.spec,count(a.appointment_id) as total_appointments from Doctor d
left join Appointment a on d.doctor_id = a.doctor_id
group by d.spec;

select d.doctor_name,count(r.prescription_id) as total_prescriptions from Doctor d
left join Appointment a on d.doctor_id = a.doctor_id
left join Prescription r on  a.appointment_id = r.appointment_id
group by d.doctor_id, d.doctor_name;