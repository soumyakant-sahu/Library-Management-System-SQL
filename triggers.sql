USE library_management_system;

-- Trigger to decrease available copies after issuing a book

DELIMITER $$

CREATE TRIGGER trg_after_book_issue
AFTER INSERT ON book_issues
FOR EACH ROW
BEGIN
    UPDATE books
    SET available_copies = available_copies - 1
    WHERE book_id = NEW.book_id
      AND available_copies > 0;
END $$

DELIMITER ;

-- Trigger to increase available copies after returning a book

DELIMITER $$

CREATE TRIGGER trg_after_book_return
AFTER UPDATE ON book_issues
FOR EACH ROW
BEGIN
    IF OLD.status <> 'RETURNED'
       AND NEW.status = 'RETURNED' THEN

        UPDATE books
        SET available_copies = available_copies + 1
        WHERE book_id = NEW.book_id;

    END IF;
END $$

DELIMITER ;