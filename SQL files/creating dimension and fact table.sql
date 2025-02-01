vCREATE TABLE DimStores (
    store_key INT IDENTITY(1,1) PRIMARY KEY,
    store_id VARCHAR(10) UNIQUE,
    location VARCHAR(100),
    size INT,
    manager VARCHAR(50),
    opening_date DATE
);

CREATE TABLE DimEmployees (
    employee_key INT IDENTITY(1,1) PRIMARY KEY,
    employee_id VARCHAR(10) UNIQUE,
    store_id VARCHAR(10),
    name VARCHAR(100),
    role VARCHAR(50),
    hire_date DATE,
    FOREIGN KEY (store_id) REFERENCES DimStores(store_id)
);

CREATE TABLE DimProducts (
    product_key INT IDENTITY(1,1) PRIMARY KEY,
    product_id VARCHAR(10) UNIQUE,
    name VARCHAR(255),
    category VARCHAR(100),
    subcategory VARCHAR(100),
    brand VARCHAR(100),
    unit_price DECIMAL(10,2)
);

CREATE TABLE DimTime (
    date_key INT PRIMARY KEY,
    full_date DATE UNIQUE,
    year INT,
    quarter INT,
    month INT,
    day INT,
    weekday VARCHAR(20)
);

CREATE TABLE FactInventory (
    inventory_id INT IDENTITY(1,1) PRIMARY KEY,
    store_id VARCHAR(10),
    product_id VARCHAR(10),
    quantity INT,
    last_updated DATETIME,
    FOREIGN KEY (store_id) REFERENCES DimStores(store_id),
    FOREIGN KEY (product_id) REFERENCES DimProducts(product_id)
);


CREATE TABLE FactSales (
    sales_id INT IDENTITY(1,1) PRIMARY KEY,  
    transaction_id VARCHAR(10),
    store_id VARCHAR(10),
    product_id VARCHAR(10),
    employee_id VARCHAR(10),
    quantity_sold INT,
    unit_price DECIMAL(10,2),
    total_sales AS (quantity_sold * unit_price),  -- Computed column
    sale_date DATE,
    FOREIGN KEY (transaction_id) REFERENCES Sales(transaction_id),
    FOREIGN KEY (store_id) REFERENCES DimStores(store_id),
    FOREIGN KEY (product_id) REFERENCES DimProducts(product_id),
    FOREIGN KEY (employee_id) REFERENCES DimEmployees(employee_id)
);





use Staging;








