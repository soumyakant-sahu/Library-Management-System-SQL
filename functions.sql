USE library_management_system;

-- ==========================================================
-- FUNCTIONS
-- ==========================================================
DELIMITER $$

CREATE FUNCTION TotalBooks()
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE total INT;

    SELECT COUNT(*)
    INTO total
    FROM books;

    RETURN total;
END $$

DELIMITER ;
SELECT TotalBooks();

DELIMITER $$

CREATE FUNCTION AvailableBooks()
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE available INT;

    SELECT SUM(available_copies)
    INTO available
    FROM books;

    RETURN available;
END $$

DELIMITER ;
SELECT AvailableBooks();

DELIMITER $$

CREATE FUNCTION TotalMembers()
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE total INT;

    SELECT COUNT(*)
    INTO total
    FROM members;

    RETURN total;
END $$

DELIMITER ;
SELECT TotalMembers();

DELIMITER $$

CREATE FUNCTION BooksBorrowed(memberId INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE borrowed INT;

    SELECT COUNT(*)
    INTO borrowed
    FROM book_issues
    WHERE member_id = memberId;

    RETURN borrowed;
END $$

DELIMITER ;
SELECT BooksBorrowed(1);

DELIMITER $$

CREATE FUNCTION OverdueBooks()
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE overdue INT;

    SELECT COUNT(*)
    INTO overdue
    FROM book_issues
    WHERE status='OVERDUE';

    RETURN overdue;
END $$

DELIMITER ;
SELECT OverdueBooks();

