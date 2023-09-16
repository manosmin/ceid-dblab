DELIMITER $
CREATE TRIGGER setEmployeeSalary BEFORE INSERT ON employee
FOR EACH ROW
BEGIN 
	SET NEW.e_salary = 650;
END$
DELIMITER ;

DELIMITER $
CREATE TRIGGER checkJournalistType BEFORE INSERT ON submits
FOR EACH ROW
BEGIN
	IF ((SELECT j_type FROM journalist INNER JOIN submits WHERE journalist.j_email=NEW.s_journalist LIMIT 1) = 'Chief') 
	THEN
		INSERT INTO editorCheck VALUES(NEW.s_journalist, NEW.s_article, 'Accepted');
	END IF;
END$
DELIMITER ;

DELIMITER $
CREATE TRIGGER checkLeafSpace BEFORE INSERT ON leafContents
FOR EACH ROW
BEGIN
	DECLARE totalArSize INT;
	DECLARE leafPages INT;
	DECLARE currArSize INT;
	SET currArSize = (SELECT ar_size FROM article INNER JOIN leafContents 
	WHERE article.ar_path=NEW.lc_article LIMIT 1);
	SET totalArSize = (SELECT SUM(ar_size) FROM article INNER JOIN leafContents 
	WHERE article.ar_path=NEW.lc_article LIMIT 1);
	SET leafPages = (SELECT l_pages FROM leaf INNER JOIN leafContents 
	WHERE leaf.l_number=NEW.lc_number 
	AND  leaf.l_newspaper=NEW.lc_newspaper LIMIT 1);
	IF((currArSize + totalArSize) > leafPages) THEN
			SIGNAL SQLSTATE VALUE '45000'
			SET MESSAGE_TEXT='Not enough space';
		END IF;
END$
DELIMITER ;