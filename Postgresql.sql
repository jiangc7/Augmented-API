CREATE SCHEMA IF NOT EXISTS public;
SET search_path TO pulic;

-- Created by Elvis Jiang 1148594, Design the database for Augmented reality system for AgResearch, we need 4 tables about paddock, gismesh, article, gisinfo


CREATE TABLE paddock (
  paddockid SERIAL PRIMARY KEY,
  size int,
  soiltemp double precision,
  soilmoisture double precision,
  drymatter double precision,
  description varchar(200),
  icon varchar(50),
  img varchar(50),
  ontap varchar(50),
  boundaryvertices jsonb,
  distance double precision
);

INSERT INTO paddock (paddockid,size, soiltemp, soilmoisture, drymatter, description, icon, img, ontap, boundaryvertices, distance)
VALUES
  (100, 23, 19.5, 15.5, 2300.4, 'This is description of paddock 1', 'Icons.rectangle_outlined', 'assets/images/paddock1.jpg', 'ontap', '[{"x":-43.58991, "y":172.56424},{"x":-40.58979, "y":172.56424}]', 1000),
  (101, 12, 20.5, 17.5, 2100.4, 'This is description of paddock 2', 'Icons.rectangle_outlined', 'assets/images/paddock2.jpg', 'ontap', '[{"x":-43.58991, "y":172.56424},{"x":-40.58979, "y":172.56424}]', 1000),
  (102, 33, 20.5, 21.5, 2100.7, 'This is description of paddock 3', 'Icons.rectangle_outlined', 'assets/images/paddock3.jpg', 'ontap', '[{"x":-43.58991, "y":172.56424},{"x":-40.58979, "y":172.56424}]', 1000);

CREATE TABLE article (
  articleid SERIAL PRIMARY KEY,
  name varchar(45) NOT NULL,
  paddockid int REFERENCES paddock(paddockid),
  latitude double precision,
  longtitude double precision,
  distance double precision,
  description varchar(200),
  icon varchar(45),
  img varchar(45),
  uri varchar(45),
  scale jsonb,
  position jsonb,
  items jsonb
);



INSERT INTO article (articleid, name, paddockid, latitude, longtitude, distance, description, icon, img, uri, scale, position, items)
VALUES
  (200, 'Water Trough #1', 100, -43.628137, 172.460873, -1, 'This is description of Water Trough 1', 'Icons.gps_fixed_sharp', 'assets/images/watertrough1.png', '', '[{"x":0.5, "y":0.5, "z":0.5}]', '[{"x":0.0, "y":-4, "z":-3}]', 
        '[{"icon": "Icons.panorama_wide_angle_outlined", "name":"Paddock", "value":"#1", "color":"Colors.white", "statusIcon":null, "array":[]},
        {"icon": "Icons.water_damage_outlined", "name":"Capacity", "value":"50 L", "color":"Colors.white", "statusIcon":null, "array":[]}
        ]'),
  (201, 'Water Trough #2', 101, -43.628137, 172.460873, -1, 'This is description of Water Trough 2', 'Icons.gps_fixed_sharp', 'assets/images/watertrough2.png', '', '[{"x":0.5, "y":0.5, "z":0.5}]', '[{"x":0.0, "y":-4, "z":-3}]', 
        '[{"icon": "Icons.panorama_wide_angle_outlined", "name":"Paddock", "value":"#1", "color":"Colors.white", "statusIcon":null, "array":[]},
        {"icon": "Icons.water_damage_outlined", "name":"Capacity", "value":"50 L", "color":"Colors.white", "statusIcon":null, "array":[]}
        ]'),
--   (202, 'Water Trough #3', 102, -43.628137, 172.460873, -1, 'This is description of Water Trough 3', 'Icons.gps_fixed_sharp', 'assets/images/watertrough2.png', '', '[{"x":0.5, "y":0.5, "z":0.5}]', '[{"x":0.0, "y":-4, "z":-3}]', 
--         '[{"icon": "Icons.panorama_wide_angle_outlined", "name":"Paddock", "value":"#1", "color":"Colors.white", "statusIcon":null, "array":[]},
--         {"icon": "Icons.water_damage_outlined", "name":"Capacity", "value":"50 L", "color":"Colors.white", "statusIcon":null, "array":[]}
--         ]');
  (202, 'Horse #1', 102, -43.628137, 172.460873, -1, 'This is description of house', 'Icons.gps_fixed_sharp', 'assets/images/horse.png', 'assets/models/horse.glb', '[{"x":0.2, "y":0.2, "z":0.2}]', '[{"x":0.0, "y":-2.5, "z":-4}]', 
        '[{"icon": "Icons.panorama_wide_angle_outlined", "name":"Paddock", "value":"#1", "color":"Colors.white", "statusIcon":null, "array":[]},
        {"icon": "Icons.water_damage_outlined", "name":"Capacity", "value":"50 L", "color":"Colors.white", "statusIcon":null, "array":[]}
        ]');


CREATE TABLE gismesh (
  gismeshid SERIAL PRIMARY KEY,
  name varchar(45) NOT NULL,
  paddockid int REFERENCES paddock(paddockid),
  latitude double precision,
  longtitude double precision,
  distance double precision,
  description varchar(200),
  icon varchar(45),
  img varchar(45),
  uri varchar(45),
  scale varchar(45),
  position varchar(45),
  gismeshitem jsonb
);

