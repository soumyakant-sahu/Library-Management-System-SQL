USE library_management_system;

-- ==========================================================
-- VIEWS
-- ==========================================================
-- View 1: Book Details
CREATE VIEW book_details AS
SELECT
    b.book_id,
    b.title,
    a.author_name,
    c.category_name,
    b.published_year,
    b.total_copies,
    b.available_copies
FROM books b
JOIN authors a
ON b.author_id = a.author_id
JOIN categories c
ON b.category_id = c.category_id;

-- View 2: Available Books
CREATE VIEW available_books AS
SELECT
    book_id,
    title,
    available_copies
FROM books
WHERE available_copies > 0;

-- View 3: Currently Issued Books
CREATE VIEW issued_books AS
SELECT
    bi.issue_id,
    b.title,
    m.first_name,
    m.last_name,
    bi.issue_date,
    bi.due_date
FROM book_issues bi
JOIN books b
ON bi.book_id = b.book_id
JOIN members m
ON bi.member_id = m.member_id
WHERE bi.status = 'ISSUED';

-- View 4: Overdue Books
CREATE VIEW overdue_books AS
SELECT
    bi.issue_id,
    b.title,
    m.first_name,
    m.last_name,
    bi.due_date
FROM book_issues bi
JOIN books b
ON bi.book_id = b.book_id
JOIN members m
ON bi.member_id = m.member_id
WHERE bi.status = 'OVERDUE';

-- View 5: Member Borrow History
CREATE VIEW member_borrow_history AS
SELECT
    m.member_id,
    CONCAT(m.first_name, ' ', m.last_name) AS member_name,
    b.title,
    bi.issue_date,
    bi.return_date,
    bi.status
FROM members m
JOIN book_issues bi
ON m.member_id = bi.member_id
JOIN books b
ON bi.book_id = b.book_id;