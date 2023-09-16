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

