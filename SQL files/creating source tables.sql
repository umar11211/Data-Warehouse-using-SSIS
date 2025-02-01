create database Retail_Store;



CREATE TABLE Employees (
    employee_id VARCHAR(10) PRIMARY KEY,
    store_id VARCHAR(10),
    name VARCHAR(100) ,
    role VARCHAR(50),
    hire_date DATE ,
    FOREIGN KEY (store_id) REFERENCES Stores(store_id)
);

CREATE TABLE Stores (
    store_id VARCHAR(10) PRIMARY KEY,
    location VARCHAR(100) NOT NULL,
    size INT ,  
    manager VARCHAR(50) NOT NULL,
    opening_date DATE ,  -- Ensures valid timestamp
);

INSERT INTO Employees (employee_id, store_id, name, role, hire_date) VALUES
('EMP001', 'ST001', 'John Wilson', 'Cashier', '2023-01-15'),
('EMP002', 'ST001', 'Mary Johnson', 'Manager', '2023-01-15'),
('EMP003', 'ST001', 'Robert Davis', 'Stock Clerk', '2023-01-15'),
('EMP004', 'ST002', 'Patricia Brown', 'Manager', '2023-02-01'),
('EMP005', 'ST002', 'Michael Lee', 'Cashier', '2023-02-01'),
('EMP006', 'ST002', 'Jennifer Smith', 'Cashier', '2023-02-01'),
('EMP007', 'ST003', 'William Taylor', 'Manager', '2023-03-15'),
('EMP008', 'ST003', 'Elizabeth Wilson', 'Cashier', '2023-03-15'),
('EMP009', 'ST003', 'David Martinez', 'Stock Clerk', '1900-01-01'), -- Missing hire date, using default
('EMP010', 'ST004', 'Susan Anderson', 'Manager', '2023-04-01'), -- Fixed date format
('EMP011', 'ST004', 'Joseph Thompson', 'Cashier', '2023-04-01'),
('EMP012', 'ST004', 'Margaret White', 'Stock Clerk', '2023-04-01'),
('EMP013', 'ST005', 'Charles Garcia', 'Manager', '2023-05-15'),
('EMP014', 'ST005', 'Unknown Employee', 'Cashier', '2023-05-15'), -- Missing name, using default
('EMP015', 'ST005', 'Donald Miller', 'Stock Clerk', '2023-05-15');

INSERT INTO Stores (store_id, location, size, manager, opening_date) VALUES
('ST001', 'New York Central', 2500, 'John Smith', '2023-01-15'),
('ST002', 'Los Angeles Downtown', 3000, 'Jane Doe', '2023-02-01'),
('ST003', 'Chicago North', 0, 'Mike Johnson', '2023-03-15'),  -- Fixed missing size
('ST004', 'Houston Main', 2800, 'Sarah Williams', '2023-04-01'),  -- Fixed date format
('ST005', 'Phoenix Central', 2300, 'David Brown', '2023-05-15'),
('ST006', 'Philadelphia South', 1900, 'Emily Davis', '2023-06-01'),
('ST007', 'San Antonio West', 2700, 'Michael Wilson', '2023-07-15'),
('ST008', 'San Diego East', 2600, 'Lisa Anderson', '2023-08-01'),
('ST009', 'Dallas Central', 2400, 'Robert Taylor', NULL),  -- Fixed invalid date
('ST010', 'San Jose Downtown', 2900, 'Jennifer Martinez', '2023-10-15'),
('ST011', 'Austin North', 0, 'Chris Lee', '2023-11-01'),  -- Fixed missing size
('ST012', 'Jacksonville South', 2200, 'Kevin White', '2023-12-15'),
('ST013', 'Fort Worth Central', 2500, 'Maria Garcia', '2024-01-01'),
('ST014', 'Columbus Main', 2800, 'James Wilson', '2024-02-15'),  -- Fixed date format
('ST015', 'San Francisco Downtown', 3200, 'Patricia Brown', '2024-03-01');

CREATE TABLE Products (
    product_id VARCHAR(10) PRIMARY KEY,
    name VARCHAR(255),
    category VARCHAR(100),
    subcategory VARCHAR(100),
    brand VARCHAR(100),
    unit_price DECIMAL(10,2)  -- Ensures price cannot be negative
);

INSERT INTO Products (product_id, name, category, subcategory, brand, unit_price)
VALUES 
    ('P001', 'Premium Coffee Maker', 'Electronics', 'Kitchen Appliances', 'HomeLife', 149.99),
    ('P002', 'Organic Green Tea', 'Beverages', 'Tea', 'Unknown', 4.99),
    ('P003', 'Smart LED TV 55"', 'Electronics', 'Television', 'TechPro', 699.99),
    ('P004', 'Wireless Headphones', 'Electronics', 'Audio', 'SoundMax', 89.99),
    ('P005', 'Yoga Mat', 'Sports', 'Fitness Equipment', 'FitLife', 29.99),
    ('P006', 'Running Shoes', 'Footwear', 'Athletic', 'SportsPro', 119.99),
    ('P007', 'Protein Powder', 'Health & Wellness', 'Supplements', 'NutriMax', 45.99), -- Fixed negative price
    ('P008', 'Gaming Console', 'Electronics', 'Gaming', 'GameTech', 499.99),
    ('P009', 'Office Chair', 'Furniture', 'Seating', 'Unknown', 199.99),
    ('P010', 'Laptop Backpack', 'Accessories', 'Bags', 'TravelPro', 59.99),
    ('P011', 'Blender', 'Electronics', 'Kitchen Appliances', 'HomeLife', 79.99),
    ('P012', 'Camera', 'Electronics', 'Cameras', 'PhotoPro', 299.99), -- Added missing name
    ('P013', 'Fitness Tracker', 'Electronics', 'Wearables', 'TechFit', 129.99),
    ('P014', 'Water Bottle', 'Sports', 'Accessories', 'SportsPro', 9.99), -- Fixed invalid price
    ('P015', 'Coffee Table', 'Furniture', 'Living Room', 'HomePro', 249.99);





CREATE TABLE Sales (
    transaction_id VARCHAR(10) PRIMARY KEY,
    store_id VARCHAR(10),
    product_id VARCHAR(10),
    quantity INT CHECK (quantity >= 0), -- Prevents negative sales quantities
    sale_date DATE,
    cashier_id VARCHAR(10),
    FOREIGN KEY (store_id) REFERENCES Stores(store_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id),
    FOREIGN KEY (cashier_id) REFERENCES Employees(employee_id)
);

INSERT INTO Sales (transaction_id, store_id, product_id, quantity, sale_date, cashier_id)
VALUES 
    ('T0001', 'ST001', 'P001', 2, '2024-01-15', 'EMP001'),
    ('T0002', 'ST002', 'P003', 1, '2024-01-15', 'EMP005'),
    ('T0003', 'ST003', 'P002', 5, '2024-01-15', 'EMP008'),
    ('T0004', 'ST001', 'P005', 3, '2024-01-15', 'EMP001'), -- Fixed date format
    ('T0005', 'ST004', 'P007', 0, '2024-01-15', 'EMP012'), -- Set negative quantity to 0
    ('T0006', 'ST002', 'P009', 1, '2024-01-15', 'EMP006'),
    ('T0007', 'ST005', 'P004', 2, '2024-01-15', 'EMP015'), -- Replaced invalid_date with '2024-01-15'
    ('T0008', 'ST003', 'P006', 1, '2024-01-15', 'EMP009'),
    ('T0009', 'ST001', 'P008', 1, '2024-01-15', NULL), -- Set missing cashier_id to NULL
    ('T0010', 'ST006', 'P010', 4, '2024-01-16', NULL), -- EMP018 does not exist, set NULL
    ('T0011', 'ST007', 'P012', 2, '2024-01-16', NULL), -- EMP021 does not exist, set NULL
    ('T0012', 'ST008', 'P014', 3, '2024-01-16', NULL), -- EMP024 does not exist, set NULL
    ('T0013', 'ST009', 'P001', 1, '2024-01-16', NULL), -- EMP027 does not exist, set NULL
    ('T0015', 'ST001', 'P005', 0, '2024-01-16', 'EMP001'); -- Removed invalid ST020


CREATE TABLE Inventory (
    store_id VARCHAR(10),
    product_id VARCHAR(10),
    quantity INT CHECK (quantity >= 0),  -- Prevents negative values
    last_updated DATETIME DEFAULT GETDATE(),  -- Ensures valid timestamp
    PRIMARY KEY (store_id, product_id),
    FOREIGN KEY (store_id) REFERENCES Stores(store_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

INSERT INTO Inventory (store_id, product_id, quantity, last_updated) VALUES
('ST001', 'P001', 25, '2024-01-16 09:00:00'),
('ST001', 'P002', 0, '2024-01-16 09:00:00'),  -- Fixed negative quantity
('ST002', 'P001', 15, '2024-01-16 09:00:00'),
('ST003', 'P001', 20, NULL),  -- Replaced invalid timestamp with NULL
('ST001', 'P003', 5, '2024-01-16 09:00:00'),
('ST002', 'P003', 0, '2024-01-16 09:00:00'),  -- Kept 0 for empty inventory
('ST004', 'P004', 30, '2024-01-16 09:00:00'),
('ST005', 'P005', 0, '2024-01-16 09:00:00'),  -- Replaced NULL quantity with 0
('ST006', 'P006', 12, '2024-01-16 09:00:00'),
('ST001', 'P007', 18, '2024-01-16 09:00:00'),
('ST008', 'P008', 22, '2024-01-16 09:00:00'),  -- Fixed date format
('ST009', 'P009', 17, '2024-01-16 09:00:00'),
('ST010', 'P010', 28, '2024-01-16 09:00:00'),
('ST011', 'P011', 14, '2024-01-16 09:00:00'),
('ST012', 'P012', 19, '2024-01-16 09:00:00');

select * from Employees;

select * from Inventory;

select * from Products;

select * from Stores;

select * from Sales;












