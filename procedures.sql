USE library_management_system;

-- ==========================================================
-- DROP EXISTING PROCEDURES
-- ==========================================================

DROP PROCEDURE IF EXISTS GetAllBooks;
DROP PROCEDURE IF EXISTS GetAllMembers;
DROP PROCEDURE IF EXISTS SearchBook;
DROP PROCEDURE IF EXISTS AddMember;
DROP PROCEDURE IF EXISTS IssueBook;
DROP PROCEDURE IF EXISTS ReturnBook;

DELIMITER $$

-- ==========================================================
-- Get All Books
-- ==========================================================

CREATE PROCEDURE GetAllBooks()
BEGIN
    SELECT *
    FROM books;
END $$

-- ==========================================================
-- Get All Members
-- ==========================================================

CREATE PROCEDURE GetAllMembers()
BEGIN
    SELECT *
    FROM members;
END $$

-- ==========================================================
-- Search Book by Title
-- ==========================================================

CREATE PROCEDURE SearchBook(
    IN p_book_title VARCHAR(100)
)
BEGIN
    SELECT *
    FROM books
    WHERE title LIKE CONCAT('%', p_book_title, '%');
END $$

-- ==========================================================
-- Add New Member
-- ==========================================================

CREATE PROCEDURE AddMember(
    IN p_first_name VARCHAR(50),
    IN p_last_name VARCHAR(50),
    IN p_email VARCHAR(100),
    IN p_phone VARCHAR(15)
)
BEGIN
    INSERT INTO members
    (
        first_name,
        last_name,
        email,
        phone
    )
    VALUES
    (
        p_first_name,
        p_last_name,
        p_email,
        p_phone
    );
END $$

-- ==========================================================
-- Issue Book
-- ==========================================================

CREATE PROCEDURE IssueBook(
    IN p_book_id INT,
    IN p_member_id INT,
    IN p_issue_date DATE,
    IN p_due_date DATE
)
BEGIN
    DECLARE copies INT;

    SELECT available_copies
    INTO copies
    FROM books
    WHERE book_id = p_book_id;

    IF copies IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Book does not exist';

    ELSEIF copies <= 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Book is not available';

    ELSE
        INSERT INTO book_issues
        (
            book_id,
            member_id,
            issue_date,
            due_date,
            status
        )
        VALUES
        (
            p_book_id,
            p_member_id,
            p_issue_date,
            p_due_date,
            'ISSUED'
        );
    END IF;
END $$

-- ==========================================================
-- Return Book
-- ==========================================================

CREATE PROCEDURE ReturnBook(
    IN p_issue_id INT
)
BEGIN
    DECLARE current_status VARCHAR(20);

    SELECT status
    INTO current_status
    FROM book_issues
    WHERE issue_id = p_issue_id;

    IF current_status IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Issue record not found';

    ELSEIF current_status = 'RETURNED' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Book has already been returned';

    ELSE
        UPDATE book_issues
        SET
            return_date = CURDATE(),
            status = 'RETURNED'
        WHERE issue_id = p_issue_id;
    END IF;
END $$

DELIMITER ;