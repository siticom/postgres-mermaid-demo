CREATE EXTENSION postgis;

CREATE TABLE
    super_market (
        id SERIAL PRIMARY KEY,
        name varchar,
        geom geometry (Point, 4326) NOT NULL
    );

CREATE TABLE
    storage_location (
        id SERIAL PRIMARY KEY,
        super_market INT REFERENCES super_market (id),
        geom geometry (Point, 4326) NOT NULL
    );