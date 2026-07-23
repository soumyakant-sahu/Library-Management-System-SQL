USE library_management_system;

-- ==========================================================
-- TRIGGERS
-- ==========================================================
DELIMITER $$

CREATE TRIGGER trg_after_book_issue
AFTER INSERT ON book_issues
FOR EACH ROW
BEGIN
    UPDATE books
    SET available_copies = available_copies - 1
    WHERE book_id = NEW.book_id;
END $$

DELIMITER ;
CALL IssueBook(
2,
4,
CURDATE(),
DATE_ADD(CURDATE(), INTERVAL 14 DAY)
);