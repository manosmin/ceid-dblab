CREATE TABLE newspaper(
n_name VARCHAR(40) NOT NULL,
n_frequency ENUM('Daily', 'Weekly', 'Monthly') NOT NULL,
n_owner VARCHAR(40) NOT NULL,
PRIMARY KEY(n_name)
);

CREATE TABLE employee(
e_date DATE NOT NULL,
e_first VARCHAR(20) NOT NULL,
e_last VARCHAR(20) NOT NULL,
e_email VARCHAR(40) NOT NULL,
e_salary INT(7) NOT NULL,
e_works VARCHAR(40) NOT NULL,
PRIMARY KEY(e_email),
CONSTRAINT FOREIGN KEY (e_works) REFERENCES newspaper(n_name)
ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE journalist(
j_email VARCHAR(40) NOT NULL REFERENCES employee(e_email),
j_past DATE NOT NULL, 
j_cv TEXT NOT NULL, 
j_type VARCHAR(40),
PRIMARY KEY(j_email)
);

CREATE TABLE administrative(
ad_email VARCHAR(40) NOT NULL REFERENCES employee(e_email),
ad_duty ENUM('Secretary', 'Logistics') NOT NULL,
ad_street VARCHAR(40) NOT NULL,
ad_streetnumber INT(4) NOT NULL,
ad_city VARCHAR(40) NOT NULL,
PRIMARY KEY(ad_email)
);

CREATE TABLE telephone(
t_number INT NOT NULL UNIQUE,
t_email VARCHAR(40) NOT NULL,
PRIMARY KEY(t_number, t_email),
CONSTRAINT FOREIGN KEY (t_email) REFERENCES administrative(ad_email)
ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE leaf(
l_number INT NOT NULL, 
l_pages INT(4) DEFAULT '30' NOT NULL, 
l_date DATE NOT NULL,
l_newspaper VARCHAR(40) NOT NULL,
PRIMARY KEY(l_number, l_newspaper),
CONSTRAINT FOREIGN KEY (l_newspaper) REFERENCES newspaper(n_name)
ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE article(
ar_path VARCHAR(255) NOT NULL, 
ar_title VARCHAR(255) NOT NULL,
ar_summary TEXT NOT NULL,
ar_publishLeaf INT NOT NULL,
ar_publishNewspaper VARCHAR(40) NOT NULL,
ar_category INT NOT NULL, 
ar_size INT NOT NULL,
PRIMARY KEY (ar_path),
CONSTRAINT FOREIGN KEY (ar_publishLeaf, ar_publishNewspaper) REFERENCES leaf(l_number, l_newspaper)
ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT FOREIGN KEY (ar_category) REFERENCES category(c_id)
ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE keyword( 
k_keyword VARCHAR(255) NOT NULL,
k_path VARCHAR(255) NOT NULL, 
PRIMARY KEY(k_keyword, k_path),
CONSTRAINT FOREIGN KEY (k_path) REFERENCES article(ar_path)
ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE submits(
s_journalist VARCHAR(40) NOT NULL, 
s_article VARCHAR(255) NOT NULL, 
s_date DATE NOT NULL,
PRIMARY KEY(s_journalist, s_article),
CONSTRAINT FOREIGN KEY (s_journalist) REFERENCES journalist(j_email)
ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT FOREIGN KEY (s_article) REFERENCES article(ar_path)
ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE category(
c_id INT NOT NULL AUTO_INCREMENT, 
c_name VARCHAR(40) NOT NULL,
c_desc TEXT NOT NULL,
c_parent INT NULL,
PRIMARY KEY(c_id),
FOREIGN KEY c_parentFK(c_parent) REFERENCES category(c_id)
);

CREATE TABLE editorCheck(
ech_journalist VARCHAR(40) NOT NULL, 
ech_article VARCHAR(255) NOT NULL, 
ech_status ENUM('Accepted', 'Rejected', 'Pending') NOT NULL,
PRIMARY KEY (ech_journalist, ech_article),
CONSTRAINT FOREIGN KEY (ech_article) REFERENCES submits(s_article)
ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT FOREIGN KEY (ech_journalist) REFERENCES submits(s_journalist)
ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE leafContents(
lc_number INT NOT NULL,
lc_newspaper VARCHAR(40) NOT NULL,
lc_article VARCHAR(255) NOT NULL,
PRIMARY KEY (lc_number, lc_newspaper, lc_article),
CONSTRAINT FOREIGN KEY (lc_number) REFERENCES leaf(l_number)
ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT FOREIGN KEY (lc_newspaper) REFERENCES leaf(l_newspaper)
ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT FOREIGN KEY (lc_article) REFERENCES article(ar_path)
ON DELETE CASCADE ON UPDATE CASCADE
);


INSERT INTO newspaper VALUES('Alpha', 'Daily', 'Sokratis Kokkalis');
INSERT INTO newspaper VALUES('Beta', 'Weekly', 'Ivan Savvidis');

INSERT INTO employee VALUES('2015-01-01', 'Spyros', 'Valimitis', 'spyros@mail.gr', 3000, 'Alpha');
INSERT INTO employee VALUES('2014-09-01', 'Nikos', 'Korompos', 'nikos@mail.gr', 2000, 'Alpha');
INSERT INTO employee VALUES('2017-04-01', 'Eleni', 'Louka', 'eleni@mail.gr', 1000, 'Beta');

INSERT INTO journalist VALUES('spyros@mail.gr', '2015-11-01', 'Nai', null);
INSERT INTO journalist VALUES('nikos@mail.gr', '2013-10-01', 'Oxi', 'Chief');

INSERT INTO administrative VALUES('spyros@mail.gr', 'Logistics', 'Olympou', 14, 'Vrysoules');
INSERT INTO administrative VALUES('eleni@mail.gr', 'Secretary', 'Spetswn', 13, 'Athens');

INSERT INTO telephone VALUES(11880, 'spyros@mail.gr');
INSERT INTO telephone VALUES(11888, 'spyros@mail.gr');
INSERT INTO telephone VALUES(100, 'eleni@mail.gr');
INSERT INTO telephone VALUES(200, 'nikos@mail.gr');

INSERT INTO leaf VALUES(1, 50, '2019-03-30', 'Alpha');
INSERT INTO leaf VALUES(2, 100, '2019-03-31', 'Alpha');
INSERT INTO leaf VALUES(1, 100, '2019-03-30', 'Beta');
INSERT INTO leaf VALUES(2, 200, '2019-04-06', 'Beta');

INSERT INTO category VALUES(0, 'Politics', 'Nai', null);
INSERT INTO category VALUES(0, 'Finance', 'Nai', null);
INSERT INTO category VALUES(0, 'Social', 'Oxi', null);
INSERT INTO category VALUES(0, 'Celebrities', 'Oxi', null);
INSERT INTO category VALUES(0, 'Sports', 'Nai', null);
INSERT INTO category VALUES(0, 'Internal', 'Nai', 1);
INSERT INTO category VALUES(0, 'External', 'Oxi', 1);
INSERT INTO category VALUES(0, 'Greek-Turkish Affairs', 'Nai', 7);
INSERT INTO category VALUES(0, 'Basketball', 'Nai', 5);
INSERT INTO category VALUES(0, 'Football', 'Oxi', 5);
INSERT INTO category VALUES(0, 'Music', 'Nai', 4);
INSERT INTO category VALUES(0, 'Cinema', 'Oxi', 4);

INSERT INTO submits VALUES('spyros@mail.gr', 'Pateras o Giannis Antetokoumpo', '2019-03-30');
INSERT INTO submits VALUES('spyros@mail.gr', 'Trikymia sto NATO', '2019-03-30');
INSERT INTO submits VALUES('spyros@mail.gr', 'Symploki sto kentro tis Athinas', '2019-03-30');
INSERT INTO submits VALUES('nikos@mail.gr', 'Ypopto krousma koronoiou sti Thessaloniki', '2019-04-06');
INSERT INTO submits VALUES('nikos@mail.gr', 'Nees ptiseis tourkikwn F16 sto Aigaio', '2019-04-06');
INSERT INTO submits VALUES('nikos@mail.gr', 'I megali anaktisi pagou stis arktikes perioxes', '2019-03-30');

INSERT INTO article VALUES
('C:\Article1.doc', 'Pateras o Giannis Antetokoumpo', 'Summary', 1, 'Alpha', 9, 5);
INSERT INTO article VALUES
('C:\Article2.doc', 'Trikymia sto NATO', 'Summary', 1, 'Alpha', 7, 25);
INSERT INTO article VALUES
('C:\Article3.doc', 'Symploki sto kentro tis Athinas', 'Summary', 1, 'Alpha', 3, 50);
INSERT INTO article VALUES
('C:\Article4.doc', 'Ypopto krousma koronoiou sti Thessaloniki', 'Summary', 2, 'Beta', 3, 40);
INSERT INTO article VALUES
('C:\Article5.doc', 'Nees ptiseis tourkikwn F16 sto Aigaio', 'Summary', 2, 'Beta', 8, 40);
INSERT INTO article VALUES
('C:\Article6.doc', 'I megali anaktisi pagou stis arktikes perioxes', 'Summary', 1, 'Beta', 3, 40);

INSERT INTO keyword VALUES('Giannis', 'C:\Article1.doc');
INSERT INTO keyword VALUES('Koronoios', 'C:\Article4.doc');

INSERT INTO leafContents VALUES(1, 'Alpha', 'C:\Article1.doc');
INSERT INTO leafContents VALUES(1, 'Alpha', 'C:\Article2.doc');
INSERT INTO leafContents VALUES(2, 'Beta', 'C:\Article4.doc');

INSERT INTO editorCheck VALUES('spyros@mail.gr', 'C:\Article1.doc', 'Pending');
INSERT INTO editorCheck VALUES('spyros@mail.gr', 'C:\Article2.doc', 'Rejected');
