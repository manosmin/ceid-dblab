DELIMITER $
CREATE PROCEDURE showLeafArticles(IN leafNo INT, IN newsName VARCHAR(255))
BEGIN
SELECT DISTINCT ech_journalist AS 'Journalist', ech_article AS 'Article'
FROM editorCheck INNER JOIN leafContents WHERE leafContents.lc_number = leafNo AND leafContents.lc_newspaper = newsName;
END$
DELIMITER ;

DELIMITER $
CREATE PROCEDURE calculateSalaryRise(IN journalistEmail VARCHAR(255), OUT newSalary INT)
BEGIN
	DECLARE regDate DATE;
	DECLARE pastDate DATE;
	DECLARE newSalary INT;
	DECLARE currSalary INT;
	DECLARE diffDate INT;
	SET diffDate = 0;
	
	SET regDate = (SELECT e_date FROM employee INNER JOIN journalist WHERE employee.e_email = journalistEmail LIMIT 1);
	SET pastDate = (SELECT j_past FROM journalist WHERE journalist.j_email = journalistEmail LIMIT 1);
	
	
	SET diffDate = DATEDIFF(m, pastDate, regDate);
	SET currSalary = (SELECT e_salary FROM employee INNER JOIN journalist WHERE employee.e_email = journalistEmail LIMIT 1);
	SET newSalary = currSalary + diffDate*0.05;
END$
DELIMITER ;