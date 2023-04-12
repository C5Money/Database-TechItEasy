DROP TABLE IF EXISTS televisions_wallBrackets CASCADE;
DROP TABLE IF EXISTS wallBrackets CASCADE;
DROP TABLE IF EXISTS televisions CASCADE;
DROP TABLE IF EXISTS remoteControllers;
DROP TABLE IF EXISTS ciModules;
DROP TABLE IF EXISTS theUsers;

CREATE TABLE theUsers(
	id INT GENERATED ALWAYS AS IDENTITY,
	username VARCHAR(255),
	password VARCHAR(255)
);

CREATE TABLE ciModules(
	id INT GENERATED ALWAYS AS IDENTITY,
	name VARCHAR(255),
	brand VARCHAR(255),
	price INT,
	current_stock INT,
	sold INT,
	PRIMARY KEY (id)
);

CREATE TABLE remoteControllers(
	id INT GENERATED ALWAYS AS IDENTITY,
	name VARCHAR(255),
	brand VARCHAR(255),
	price INT,
	current_stock INT,
	sold INT,
	compatible_with VARCHAR(255),
	battery_type VARCHAR(255),
	PRIMARY KEY (id)
);

CREATE TABLE televisions(
	id INT GENERATED ALWAYS AS IDENTITY,
	name VARCHAR(255),
	brand VARCHAR(255),
	price INT,
	current_stock INT,
	sold INT,
	type VARCHAR(255),
	available INT,
	refresh_rate INT,
	screen_type VARCHAR(255),
	ciModule_id INT,
	compatible_remoteController_id INT,
	PRIMARY KEY (id),
	FOREIGN KEY (ciModule_id) REFERENCES ciModules(id),
	FOREIGN KEY (compatible_remoteController_id) REFERENCES remoteControllers(id)
);

CREATE TABLE wallBrackets(
	id INT GENERATED ALWAYS AS IDENTITY,
	name VARCHAR(255),
	brand VARCHAR(255),
	price INT,
	current_stock INT,
	sold INT,
	PRIMARY KEY (id)
);

CREATE TABLE televisions_wallBrackets(
	televisions_id INT,
	wallBrackets_id INT,
	FOREIGN KEY (televisions_id) REFERENCES televisions(id),
	FOREIGN KEY (wallBrackets_id) REFERENCES wallBrackets(id)
);

INSERT INTO televisions(name, brand, price, current_stock, sold, type, available, refresh_rate, screen_type, ciModule_id)
	VALUES('LG monitor', 'LG', 1200, 5, 3, 'Monitor-0222', 3, 60, '4HD', (SELECT id FROM ciModules WHERE name='LG-Module')),
		('Home Cinema', 'Samsung', 2500, 2, 7, '65-inch', 3, 100, '8HD', (SELECT id FROM ciModules WHERE name='Samsung-Module'));

INSERT INTO remoteControllers(name, brand, price, current_stock, sold, compatible_with, battery_type)
	VALUES('LG remote', 'LG', 29, 4, 2, 'LG television', 'AAA'),
		('Samsung remote', 'Universe', 29, 4, 2, 'Samsung television', '6xAAA');
	
INSERT INTO ciModules(name, brand, price, current_stock, sold)
	VALUES('LG-Module', 'LG', 59, 2, 1),
		('Samsung-Module', 'Samsung', 112, 4, 1),
		('One-For-All', 'Universe', 59, 9, 5);
	
INSERT INTO wallBrackets(name, brand, price, current_stock, sold)
	VALUES('TV Chopstick', 'Tesla', 89, 2, 0),
		('Mighty Arms', 'Universe', 35, 1, 12);

INSERT INTO televisions_wallBrackets(televisions_id, wallBrackets_id)
	VALUES((SELECT id FROM televisions WHERE brand='LG'), (SELECT id FROM wallBrackets WHERE brand='Tesla')),
		((SELECT id FROM televisions WHERE brand='LG'), (SELECT id FROM wallBrackets WHERE brand='Universe')),
		((SELECT id FROM televisions WHERE brand='Samsung'), (SELECT id FROM wallBrackets WHERE brand='Universe'));

	
SELECT televisions.name AS tv, televisions.price AS tv_price, remoteControllers.name AS remotecontroller, remoteControllers.compatible_with AS compatibility, remoteControllers.price AS remotecontroller_price
FROM televisions
JOIN remoteControllers ON televisions.brand=remoteControllers.brand;

SELECT televisions.name AS tv, televisions.price AS tv_price, wallBrackets.name AS wallbrackets, wallBrackets.price AS wallbracket_price
FROM televisions_wallBrackets
JOIN televisions ON televisions.id=televisions_wallBrackets.televisions_id
JOIN wallBrackets ON wallBrackets.id=televisions_wallBrackets.wallBrackets_id;

