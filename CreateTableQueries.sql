CREATE TABLE Employee ( 
    employee_id VARCHAR(10) PRIMARY KEY, 
    emp_name VARCHAR(50) NOT NULL, 
    emp_phone VARCHAR(15) CHECK (emp_phone LIKE '+%' OR emp_phone LIKE '[0-9]%'), -- Ensures phone numbers start with a '+' or a digit
    grade VARCHAR(15) NOT NULL CHECK (grade IN ('Trainee', 'Mechanic', 'Apprentice', 'Senior Mechanic')) -- Ensures grade is one of the allowed values
);

CREATE TABLE EmployeeUnavailability (
    employee_id VARCHAR(10) NOT NULL,
    unavailable_start_date DATE NOT NULL,
    unavailable_end_date DATE NOT NULL CHECK (unavailable_end_date >= unavailable_start_date), -- Ensures valid date ranges
    reason VARCHAR(255),
    PRIMARY KEY (employee_id, unavailable_start_date, unavailable_end_date),
    FOREIGN KEY (employee_id) REFERENCES Employee(employee_id) ON DELETE CASCADE
);

CREATE TABLE Customer (
    customer_id VARCHAR(10) PRIMARY KEY,
    cust_name VARCHAR(50) NOT NULL,
    cust_email VARCHAR(70),
    cust_phoneno VARCHAR(15) CHECK (cust_phoneno LIKE '+%' OR cust_phoneno LIKE '[0-9]%'), -- Ensures phone numbers start with a '+' or a digit
    CONSTRAINT chk_email_format CHECK (cust_email LIKE '%@%' OR cust_email IS NULL) -- Allows NULL or valid email format
);

CREATE TABLE Vehicle ( 
    registration VARCHAR(15) PRIMARY KEY, 
    make VARCHAR(30), 
    model VARCHAR(50), 
    date_of_manufacture DATE, 
    customer_id VARCHAR(10) NOT NULL, 
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id) ON DELETE CASCADE,
    CONSTRAINT chk_registration_uppercase_alphanumeric CHECK (registration NOT LIKE '%[^A-Z0-9]%') -- Ensures only uppercase alphanumeric characters
);

CREATE TABLE Services ( 
    service_id VARCHAR(15) PRIMARY KEY, 
    registration VARCHAR(15) NOT NULL, 
    dropoff_date DATE NOT NULL, 
    dropoff_time TIME NOT NULL, 
    work_required VARCHAR(255) NOT NULL, 
    mileage INT CHECK (mileage >= 0), -- Ensures mileage cannot be negative
    next_service DATE CHECK (next_service >= dropoff_date), -- Ensures next service is after dropoff date
    FOREIGN KEY (registration) REFERENCES Vehicle(registration) ON DELETE CASCADE
);

CREATE TABLE ServiceEmployee (
    service_id VARCHAR(15) NOT NULL,
    employee_id VARCHAR(10) NOT NULL,    
    time_spent TIME NOT NULL CHECK (time_spent > '00:00:00'), -- Ensures valid time spent is greater than zero
    FOREIGN KEY (service_id) REFERENCES Services(service_id) ON DELETE CASCADE,
    FOREIGN KEY (employee_id) REFERENCES Employee(employee_id) ON DELETE CASCADE,
    CONSTRAINT unique_service_employee UNIQUE (service_id, employee_id) -- Ensures uniqueness of service_id-employee_id pair
);

