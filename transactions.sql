USE library_management_system;

-- Transaction to issue a book

START TRANSACTION;

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
    5,
    2,
    CURDATE(),
    DATE_ADD(CURDATE(), INTERVAL 14 DAY),
    'ISSUED'
);

COMMIT;

-- Transaction to return a book

START TRANSACTION;

UPDATE book_issues
SET
    return_date = CURDATE(),
    status = 'RETURNED'
WHERE issue_id = 3;

COMMIT;

-- Transaction with rollback

START TRANSACTION;

UPDATE books
SET available_copies = available_copies - 5
WHERE book_id = 1;

ROLLBACK;