USE library_management_system;

-- ==========================================================
-- DROP EXISTING FUNCTIONS
-- ==========================================================

DROP FUNCTION IF EXISTS TotalBooks;
DROP FUNCTION IF EXISTS AvailableBooks;
DROP FUNCTION IF EXISTS TotalMembers;
DROP FUNCTION IF EXISTS BooksBorrowed;
DROP FUNCTION IF EXISTS OverdueBooks;

DELIMITER $$

-- ==========================================================
-- Total Number of Books
-- ==========================================================

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

-- ==========================================================
-- Total Available Book Copies
-- ==========================================================

CREATE FUNCTION AvailableBooks()
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE available INT;

    SELECT COALESCE(SUM(available_copies), 0)
    INTO available
    FROM books;

    RETURN available;
END $$

-- ==========================================================
-- Total Members
-- ==========================================================

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

-- ==========================================================
-- Total Books Borrowed by a Member
-- ==========================================================

CREATE FUNCTION BooksBorrowed(
    p_member_id INT
)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE borrowed INT;

    SELECT COUNT(*)
    INTO borrowed
    FROM book_issues
    WHERE member_id = p_member_id;

    RETURN borrowed;
END $$

-- ==========================================================
-- Total Overdue Books
-- ==========================================================

CREATE FUNCTION OverdueBooks()
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE overdue INT;

    SELECT COUNT(*)
    INTO overdue
    FROM book_issues
    WHERE status = 'OVERDUE';

    RETURN overdue;
END $$

DELIMITER ;