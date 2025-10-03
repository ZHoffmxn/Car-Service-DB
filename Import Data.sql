INSERT INTO Employee (employee_id, emp_name, emp_phone, grade)
SELECT DISTINCT
    employee_id,         
	emp_name,
    emp_phone,                
	grade
FROM CarServiceData
WHERE employee_id IS NOT NULL;

-- Insert into Customers table
INSERT INTO Customer (customer_id, cust_name, cust_email, cust_phoneno)
SELECT DISTINCT
    customer_id,
    cust_name,
    cust_email,
    cust_phoneno
FROM CarServiceData;

-- Insert into Vehicles table
INSERT INTO Vehicle (registration, make, model, date_of_manufacture, customer_id)
SELECT DISTINCT
    registration,
    make,
    model,
    date_of_manufacture,
    customer_id
FROM CarServiceData;

-- Insert into Services table
INSERT INTO Services (service_id, registration, dropoff_date, dropoff_time, work_required, mileage, next_service)
SELECT DISTINCT
    service_id,
    registration,
	dropoff_date,
	dropoff_time,
	work_required,
	milage,
	next_service
FROM CarServiceData;

INSERT INTO ServiceEmployee (service_id, employee_id, time_spent)
SELECT DISTINCT
    service_id,
    employee_id,
	time_spent
FROM CarServiceData
WHERE service_id IS NOT NULL AND employee_id IS NOT NULL;
