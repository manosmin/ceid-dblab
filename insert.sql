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