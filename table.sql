CREATE TABLE users (
	userId		SERIAL PRIMARY KEY,
	userName    TEXT  NOT NULL UNIQUE,
	userRole	TEXT NOT NULL,
	userAge     INTEGER NOT NULL CHECK (userAge > 0),
	userState   TEXT NOT NULL

 );

CREATE TABLE categories (
	catID	SERIAL PRIMARY KEY,
	catName	TEXT NOT NULL UNIQUE,
	catDescript	TEXT NOT NULL
);

CREATE TABLE products (
	proID		SERIAL PRIMARY KEY,
	proName		TEXT NOT NULL,
	proCatID	INTEGER REFERENCES categories (catID) NOT NULL,
	SKU			TEXT NOT NULL UNIQUE,
	proPrice	INTEGER NOT NULL CHECK (proPrice > 0)
);

CREATE TABLE orders (
	orderID		SERIAL PRIMARY KEY,
	proID		INTEGER REFERENCES products (proID) NOT NULL,
	proQuantity	INTEGER NOT NULL,
	userID		INTEGER REFERENCES users (userId) NOT NULL,
	proPrice	INTEGER NOT NULL,
	orderTime	TIMESTAMP NOT NULL
);

INSERT into categories (catName, catDescript) values ('Appliances', 'Small kitchen Applicances, Microwaves, Refrigerators');
INSERT into categories (catName, catDescript) values ('TV & Home Theater', 'Televisions, TV stands, Mounts, and Furnitures');
INSERT into categories (catName, catDescript) values ('Computers & Tablets', 'Laptops, Desktops, Mintors, and printers');
INSERT into categories (catName, catDescript) values ('Cell Phones', 'Verizon, AT&T, Sprint, and T-Mobile');
INSERT into categories (catName, catDescript) values ('Cameras & Camcorders', 'Digital SLR Cameras, Mirrorless Cameras');
INSERT into categories (catName, catDescript) values ('Audio', 'iPod, Headphones, Docks, Radios & Boomboxes');
INSERT into categories (catName, catDescript) values ('Car Electronics & GPS', 'GPS navigation & Accessories, Car Audio, Car Video');
INSERT into categories (catName, catDescript) values ('Video Games, Movies & Music', 'PlayStation 4, Xbox One, and PlayStation 3');
INSERT into categories (catName, catDescript) values ('Health, Fitness & Beauty', 'Activity Trackers & Pedometers, Assistive Technology');
INSERT into categories (catName, catDescript) values ('Connected Home & Housewares', 'Appliance & Outlet Controls, Home Alarms & Sensors');
INSERT into categories (catName, catDescript) values ('Toys, Games & Drones', 'Action Figures, Building Sets & Blocks, Drones & Accessories');
INSERT into categories (catName, catDescript) values ('Wearable Technology', 'Action Camcorders, Activity Trackers & Pedometers');



INSERT into products (proName, proCatID, SKU, proPrice) values ('Refrigerators', 1, '00000000', 300);
INSERT into products (proName, proCatID, SKU, proPrice) values ('Small Kitchen Appliances', 1, '00000001', 10);
INSERT into products (proName, proCatID, SKU, proPrice) values ('Freezers & Ice Makers', 1, '00000010', 35);
INSERT into products (proName, proCatID, SKU, proPrice) values ('Microwaves', 1, '00000011', 200);
INSERT into products (proName, proCatID, SKU, proPrice) values ('Ranges, Cooktops & Ovens', 1, '00000100', 210);
INSERT into products (proName, proCatID, SKU, proPrice) values ('LED TVs', 2, '00000101', 400);
INSERT into products (proName, proCatID, SKU, proPrice) values ('Receivers & Amplifiers', 2, '00000110', 450);
INSERT into products (proName, proCatID, SKU, proPrice) values ('Video', 2, '00000111', 45);
INSERT into products (proName, proCatID, SKU, proPrice) values ('iPad', 3, '00001000', 450);
INSERT into products (proName, proCatID, SKU, proPrice) values ('PC Laptops', 3, '00001001', 799);
INSERT into products (proName, proCatID, SKU, proPrice) values ('MacBooks', 3, '00001010', 1899);
INSERT into products (proName, proCatID, SKU, proPrice) values ('DSLR Body & Lens', 5, '00001011', 200);
INSERT into products (proName, proCatID, SKU, proPrice) values ('Wi-Fi Mirrorless Cameras', 5, '00001100', 1000);
INSERT into products (proName, proCatID, SKU, proPrice) values ('Waterproof Point & Shoot', 5, '00001101', 1045);
INSERT into products (proName, proCatID, SKU, proPrice) values ('Headphones', 6, '00001110', 79);
INSERT into products (proName, proCatID, SKU, proPrice) values ('Home Audio', 6, '00001111', 77);
INSERT into products (proName, proCatID, SKU, proPrice) values ('Speakers', 6, '00010000', 83);
INSERT into products (proName, proCatID, SKU, proPrice) values ('In-Car Entertainment', 7, '00010001', 107);
INSERT into products (proName, proCatID, SKU, proPrice) values ('Connectivity', 7, '00010010', 145);
INSERT into products (proName, proCatID, SKU, proPrice) values ('Car Safety & Convenience', 7, '00010011', 105);
INSERT into products (proName, proCatID, SKU, proPrice) values ('Video Games', 8, '00010100', 25);
INSERT into products (proName, proCatID, SKU, proPrice) values ('Movies & TV Shows', 8, '00010101', 75);
INSERT into products (proName, proCatID, SKU, proPrice) values ('Music', 8, '00010110', 59);
INSERT into products (proName, proCatID, SKU, proPrice) values ('Smart & Wi-Fi Thermostats', 10, '00010111', 125);
INSERT into products (proName, proCatID, SKU, proPrice) values ('Security Cameras & Systems', 10, '00011000', 135);
INSERT into products (proName, proCatID, SKU, proPrice) values ('Drones & Drone Accessories', 11, '00011001', 55);
INSERT into products (proName, proCatID, SKU, proPrice) values ('Toys', 11, '00011010', 67);
INSERT into products (proName, proCatID, SKU, proPrice) values ('Apple Watch', 12, '00011011', 699);
INSERT into products (proName, proCatID, SKU, proPrice) values ('Smartwatches & Accessories', 12, '00011100', 355);
INSERT into products (proName, proCatID, SKU, proPrice) values ('Activity Trackers & Pedometers', 12, '00011101', 245);
INSERT into products (proName, proCatID, SKU, proPrice) values ('iPhone', 4, '00011110', 899);




