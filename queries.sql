USE library_management_system;

-- ==========================================================
-- BASIC QUERIES
-- ==========================================================

-- 1. View all authors
SELECT * FROM authors;

-- 2. View all categories
SELECT * FROM categories;

-- 3. View all books
SELECT * FROM books;

-- 4. View all members
SELECT * FROM members;

-- 5. View all book issue records
SELECT * FROM book_issues;

-- ==========================================================
-- JOIN QUERIES
-- ==========================================================

-- 6. List all books with author and category names
SELECT
    b.book_id,
    b.title,
    a.author_name,
    c.category_name,
    b.published_year,
    b.available_copies
FROM books b
JOIN authors a
ON b.author_id = a.author_id
JOIN categories c
ON b.category_id = c.category_id;

-- 7. Display all issued books with member details
SELECT
    bi.issue_id,
    m.first_name,
    m.last_name,
    b.title,
    bi.issue_date,
    bi.due_date,
    bi.return_date,
    bi.status
FROM book_issues bi
JOIN books b
ON bi.book_id = b.book_id
JOIN members m
ON bi.member_id = m.member_id;

-- 8. Display books currently issued
SELECT
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
WHERE bi.status='ISSUED';

-- 9. Display overdue books
SELECT
    b.title,
    m.first_name,
    m.last_name,
    bi.due_date
FROM book_issues bi
JOIN books b
ON bi.book_id=b.book_id
JOIN members m
ON bi.member_id=m.member_id
WHERE bi.status='OVERDUE';

-- 10. Display returned books
SELECT
    b.title,
    m.first_name,
    m.last_name,
    bi.return_date
FROM book_issues bi
JOIN books b
ON bi.book_id=b.book_id
JOIN members m
ON bi.member_id=m.member_id
WHERE bi.status='RETURNED';

-- ==========================================================
-- AGGREGATE FUNCTIONS
-- ==========================================================

-- 11. Count total books
SELECT COUNT(*) AS total_books
FROM books;

-- 12. Count total members
SELECT COUNT(*) AS total_members
FROM members;

-- 13. Count books in each category
SELECT
    c.category_name,
    COUNT(b.book_id) AS total_books
FROM categories c
LEFT JOIN books b
ON c.category_id=b.category_id
GROUP BY c.category_name;

-- 14. Count books by each author
SELECT
    a.author_name,
    COUNT(b.book_id) AS total_books
FROM authors a
LEFT JOIN books b
ON a.author_id=b.author_id
GROUP BY a.author_name;

-- 15. Total issued books
SELECT COUNT(*) AS total_issued
FROM book_issues
WHERE status='ISSUED';

-- 16. Total overdue books
SELECT COUNT(*) AS overdue_books
FROM book_issues
WHERE status='OVERDUE';

-- ==========================================================
-- GROUP BY & HAVING
-- ==========================================================

-- 17. Members who borrowed more than one book
SELECT
    member_id,
    COUNT(*) AS books_borrowed
FROM book_issues
GROUP BY member_id
HAVING COUNT(*) > 1;

-- 18. Authors having more than one book
SELECT
    a.author_name,
    COUNT(*) AS total_books
FROM books b
JOIN authors a
ON b.author_id=a.author_id
GROUP BY a.author_name
HAVING COUNT(*)>1;

-- ==========================================================
-- SUBQUERIES
-- ==========================================================

-- 19. Book(s) with maximum copies
SELECT *
FROM books
WHERE total_copies=(
    SELECT MAX(total_copies)
    FROM books
);

-- 20. Member(s) who borrowed the maximum number of books
SELECT
    m.first_name,
    m.last_name
FROM members m
WHERE member_id IN(
    SELECT member_id
    FROM book_issues
    GROUP BY member_id
    HAVING COUNT(*)=(
        SELECT MAX(book_count)
        FROM(
            SELECT COUNT(*) AS book_count
            FROM book_issues
            GROUP BY member_id
        ) AS counts
    )
);

-- ==========================================================
-- SEARCH QUERIES
-- ==========================================================

-- 21. Search books by title
SELECT *
FROM books
WHERE title LIKE '%Harry%';

-- 22. Search books by author
SELECT
    b.title,
    a.author_name
FROM books b
JOIN authors a
ON b.author_id=a.author_id
WHERE a.author_name='J.K. Rowling';

-- 23. Search books by category
SELECT
    b.title,
    c.category_name
FROM books b
JOIN categories c
ON b.category_id=c.category_id
WHERE c.category_name='Fantasy';

-- ==========================================================
-- MISCELLANEOUS
-- ==========================================================

-- 24. Available books
SELECT
    title,
    available_copies
FROM books
WHERE available_copies>0;

-- 25. Books never issued
SELECT
    title
FROM books
WHERE book_id NOT IN(
    SELECT DISTINCT book_id
    FROM book_issues
);

-- 26. Members who never borrowed any book
SELECT
    first_name,
    last_name
FROM members
WHERE member_id NOT IN(
    SELECT DISTINCT member_id
    FROM book_issues
);