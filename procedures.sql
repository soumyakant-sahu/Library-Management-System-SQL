USE library_management_system;

-- ==========================================================
-- STORED PROCEDURES
-- ==========================================================
DELIMITER $$

CREATE PROCEDURE GetAllBooks()
BEGIN
    SELECT *
    FROM books;
END $$

DELIMITER ;

DELIMITER $$

CREATE PROCEDURE GetAllMembers()
BEGIN
    SELECT *
    FROM members;
END $$

DELIMITER ;

DELIMITER $$

CREATE PROCEDURE SearchBook(
    IN bookTitle VARCHAR(100)
)
BEGIN
    SELECT *
    FROM books
    WHERE title LIKE CONCAT('%', bookTitle, '%');
END $$

DELIMITER ;

DELIMITER $$

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

DELIMITER ;

DELIMITER $$

CREATE PROCEDURE IssueBook(
    IN p_book_id INT,
    IN p_member_id INT,
    IN p_issue_date DATE,
    IN p_due_date DATE
)
BEGIN

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

END $$

DELIMITER ;

DELIMITER $$

CREATE PROCEDURE ReturnBook(
    IN p_issue_id INT
)
BEGIN

    UPDATE book_issues
    SET
        return_date = CURDATE(),
        status = 'RETURNED'
    WHERE issue_id = p_issue_id;

END $$

DELIMITER ;