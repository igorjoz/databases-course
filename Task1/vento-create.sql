CREATE TABLE categories
(
    id INT PRIMARY KEY,
    name NVARCHAR(255) NOT NULL,
    slug NVARCHAR(255) UNIQUE NOT NULL
);

CREATE TABLE subcategories
(
    id INT PRIMARY KEY,
    name NVARCHAR(255) NOT NULL,
    slug NVARCHAR(255) NOT NULL,
    category_id INT NOT NULL,
    FOREIGN KEY (category_id) REFERENCES categories(id)
);

CREATE TABLE brands
(
    id INT PRIMARY KEY,
    name NVARCHAR(255) NOT NULL,
    slug NVARCHAR(255) UNIQUE NOT NULL
);

CREATE TABLE products
(
    id INT PRIMARY KEY,
    name NVARCHAR(255) NOT NULL,
    slug NVARCHAR(255) UNIQUE NOT NULL,
    description NVARCHAR(MAX),
    valid_from DATETIME NULL,
    valid_to DATETIME NULL,
    is_available BIT NOT NULL,
    weight DECIMAL(10, 2) NULL,
    requires_pallet BIT NOT NULL,
    estimated_shipping_time INT NULL,
    boost_positioning BIT NOT NULL,
    category_id INT NOT NULL,
    subcategory_id INT NULL,
    brand_id INT NULL,
    FOREIGN KEY (category_id) REFERENCES categories(id),
    FOREIGN KEY (subcategory_id) REFERENCES subcategories(id),
    FOREIGN KEY (brand_id) REFERENCES brands(id)
);

CREATE TABLE product_images
(
    id INT PRIMARY KEY,
    path NVARCHAR(MAX) NOT NULL,
    mini_path NVARCHAR(MAX) NOT NULL,
    product_id INT NOT NULL,
    FOREIGN KEY (product_id) REFERENCES products(id)
);

CREATE TABLE parameters
(
    id INT PRIMARY KEY,
    name NVARCHAR(255) NOT NULL,
    category_id INT NOT NULL,
    FOREIGN KEY (category_id) REFERENCES categories(id)
);

CREATE TABLE product_parameters
(
    id INT PRIMARY KEY,
    value NVARCHAR(255) NOT NULL,
    parameter_id INT NOT NULL,
    product_id INT NOT NULL,
    FOREIGN KEY (parameter_id) REFERENCES parameters(id),
    FOREIGN KEY (product_id) REFERENCES products(id)
);

CREATE TABLE offers
(
    id INT PRIMARY KEY,
    price DECIMAL(10, 2) NOT NULL,
    valid_from DATETIME NULL,
    valid_to DATETIME NULL,
    product_id INT NOT NULL,
    FOREIGN KEY (product_id) REFERENCES products(id)
);

CREATE TABLE payment_methods
(
    id INT PRIMARY KEY,
    name NVARCHAR(255) NOT NULL
);

CREATE TABLE orders
(
    id INT PRIMARY KEY,
    session_id NVARCHAR(255) UNIQUE NOT NULL,
    deleted_at DATETIME NULL,
    additional_information NVARCHAR(MAX) NULL,
    total_price DECIMAL(10, 2) NOT NULL,
    products_price DECIMAL(10, 2) NOT NULL,
    amount INT NOT NULL,
    total_weight DECIMAL(10, 2) NOT NULL,
    name NVARCHAR(255) NOT NULL,
    surname NVARCHAR(255) NOT NULL,
    phone_number NVARCHAR(20) NOT NULL,
    email_address NVARCHAR(255) NOT NULL,
    payment_method_id INT NOT NULL,
    FOREIGN KEY (payment_method_id) REFERENCES payment_methods(id)
);

CREATE TABLE p24_payments
(
    id INT PRIMARY KEY,
    status NVARCHAR(255) NOT NULL,
    session_id NVARCHAR(255) NOT NULL,
    error_code INT NULL,
    p24_sign NVARCHAR(255) NULL,
    p24_method INT NULL,
    p24_token NVARCHAR(255) NULL,
    p24_order_id INT NULL,
    is_payment_completed BIT NOT NULL,
    order_id INT NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(id)
);

CREATE TABLE delivery_methods
(
    id INT PRIMARY KEY,
    name NVARCHAR(255) NOT NULL
);

CREATE TABLE deliveries
(
    id INT PRIMARY KEY,
    total_weight DECIMAL(10, 2) NOT NULL,
    required_pallets_quantity INT NOT NULL,
    transport_price DECIMAL(10, 2) NOT NULL,
    phone_number NVARCHAR(20) NOT NULL,
    name NVARCHAR(255) NOT NULL,
    surname NVARCHAR(255) NOT NULL,
    street NVARCHAR(255) NOT NULL,
    city NVARCHAR(255) NOT NULL,
    postal_code NVARCHAR(10) NOT NULL,
    order_id INT NOT NULL,
    delivery_method_id INT NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(id),
    FOREIGN KEY (delivery_method_id) REFERENCES delivery_methods(id)
);

CREATE TABLE order_offers
(
    id INT PRIMARY KEY,
    quantity INT NOT NULL,
    offer_id INT NOT NULL,
    delivery_id INT NULL,
    order_id INT NOT NULL,
    FOREIGN KEY (offer_id) REFERENCES offers(id),
    FOREIGN KEY (delivery_id) REFERENCES deliveries(id),
    FOREIGN KEY (order_id) REFERENCES orders(id)
);