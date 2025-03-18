CREATE EXTENSION IF NOT EXISTS postgis;

CREATE TABLE super_market (
    id SERIAL PRIMARY KEY,
    name VARCHAR NOT NULL,
    geom GEOMETRY(Point, 4326) NOT NULL,
    service_area GEOMETRY(Polygon, 4326)
);

CREATE TABLE storage_location (
    id SERIAL PRIMARY KEY,
    super_market_id INT REFERENCES super_market(id) ON DELETE CASCADE,
    name VARCHAR NOT NULL,
    geom GEOMETRY(Point, 4326) NOT NULL,
    coverage_area GEOMETRY(MultiPolygon, 4326)
);

CREATE TABLE category (
    id SERIAL PRIMARY KEY,
    name VARCHAR NOT NULL,
    parent_id INT REFERENCES category(id) ON DELETE SET NULL
);

CREATE TABLE product (
    id SERIAL PRIMARY KEY,
    name VARCHAR NOT NULL,
    category_id INT REFERENCES category(id) ON DELETE SET NULL,
    price DECIMAL(10,2) NOT NULL
);

CREATE TABLE super_market_inventory (
    id SERIAL PRIMARY KEY,
    super_market_id INT REFERENCES super_market(id) ON DELETE CASCADE,
    product_id INT REFERENCES product(id) ON DELETE CASCADE,
    stock INT NOT NULL
);

CREATE TABLE employee (
    id SERIAL PRIMARY KEY,
    super_market_id INT REFERENCES super_market(id) ON DELETE CASCADE,
    name VARCHAR NOT NULL,
    role VARCHAR NOT NULL,
    home_location GEOMETRY(Point, 4326)
);

CREATE TABLE supplier (
    id SERIAL PRIMARY KEY,
    name VARCHAR NOT NULL,
    contact_info TEXT,
    headquarters_location GEOMETRY(Point, 4326)
);

CREATE TABLE supplier_product (
    id SERIAL PRIMARY KEY,
    supplier_id INT REFERENCES supplier(id) ON DELETE CASCADE,
    product_id INT REFERENCES product(id) ON DELETE CASCADE,
    delivery_time_days INT NOT NULL
);

CREATE TABLE customer (
    id SERIAL PRIMARY KEY,
    name VARCHAR NOT NULL,
    email VARCHAR UNIQUE NOT NULL,
    home_location GEOMETRY(Point, 4326)
);

CREATE TABLE orders (
    id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES customer(id) ON DELETE CASCADE,
    order_date TIMESTAMP DEFAULT NOW(),
    delivery_location GEOMETRY(Point, 4326)
);

CREATE TABLE order_details (
    id SERIAL PRIMARY KEY,
    order_id INT REFERENCES orders(id) ON DELETE CASCADE,
    product_id INT REFERENCES product(id) ON DELETE CASCADE,
    quantity INT NOT NULL,
    price DECIMAL(10,2) NOT NULL
);
