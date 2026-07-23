USE library_management_system;

-- ==========================================================
-- TRANSACTION 1 : Issue a Book
-- ==========================================================

START TRANSACTION;

CALL IssueBook(
    5,
    2,
    CURDATE(),
    DATE_ADD(CURDATE(), INTERVAL 14 DAY)
);

COMMIT;

-- ==========================================================
-- TRANSACTION 2 : Return a Book
-- ==========================================================

START TRANSACTION;

CALL ReturnBook(3);

COMMIT;

-- ==========================================================
-- TRANSACTION 3 : Rollback Example
-- ==========================================================

START TRANSACTION;

UPDATE books
SET total_copies = total_copies + 5
WHERE book_id = 1;

ROLLBACK;