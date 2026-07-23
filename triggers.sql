USE library_management_system;

-- ==========================================================
-- DROP EXISTING TRIGGERS
-- ==========================================================

DROP TRIGGER IF EXISTS trg_after_book_issue;
DROP TRIGGER IF EXISTS trg_after_book_return;

DELIMITER $$

-- ==========================================================
-- Trigger: Decrease available copies after issuing a book
-- ==========================================================

CREATE TRIGGER trg_after_book_issue
AFTER INSERT ON book_issues
FOR EACH ROW
BEGIN
    UPDATE books
    SET available_copies = available_copies - 1
    WHERE book_id = NEW.book_id
      AND available_copies > 0;
END $$

-- ==========================================================
-- Trigger: Increase available copies after returning a book
-- ==========================================================

CREATE TRIGGER trg_after_book_return
AFTER UPDATE ON book_issues
FOR EACH ROW
BEGIN
    IF OLD.status <> 'RETURNED'
       AND NEW.status = 'RETURNED' THEN

        UPDATE books
        SET available_copies = available_copies + 1
        WHERE book_id = NEW.book_id
          AND available_copies < total_copies;

    END IF;
END $$

DELIMITER ;