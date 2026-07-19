USE library_management_system;

-- Insert Authors
INSERT INTO authors (author_name, country) VALUES
('J.K. Rowling', 'United Kingdom'),
('George Orwell', 'United Kingdom'),
('Harper Lee', 'United States'),
('Paulo Coelho', 'Brazil'),
('Chetan Bhagat', 'India'),
('Ruskin Bond', 'India'),
('R.K. Narayan', 'India'),
('Dan Brown', 'United States'),
('Agatha Christie', 'United Kingdom'),
('Jane Austen', 'United Kingdom'),
('Leo Tolstoy', 'Russia'),
('Mark Twain', 'United States'),
('Jules Verne', 'France'),
('Arthur Conan Doyle', 'United Kingdom'),
('Khaled Hosseini', 'Afghanistan'),
('Charles Dickens', 'United Kingdom'),
('Stephen King', 'United States'),
('J.R.R. Tolkien', 'United Kingdom'),
('Ernest Hemingway', 'United States'),
('Victor Hugo', 'France');

-- Insert Categories
INSERT INTO categories (category_name) VALUES
('Fiction'),
('Science Fiction'),
('Mystery'),
('Fantasy'),
('Biography'),
('History'),
('Technology'),
('Self Help'),
('Romance'),
('Horror');

-- Insert Books
INSERT INTO books (title, author_id, category_id, isbn, published_year, total_copies, available_copies) VALUES
('Harry Potter and the Philosopher''s Stone', 1, 4, '9780747532743', 1997, 10, 10),
('Harry Potter and the Chamber of Secrets', 1, 4, '9780747538486', 1998, 8, 8),
('1984', 2, 1, '9780451524935', 1949, 12, 12),
('Animal Farm', 2, 1, '9780451526342', 1945, 10, 10),
('To Kill a Mockingbird', 3, 1, '9780061120084', 1960, 7, 7),
('The Alchemist', 4, 8, '9780062315007', 1988, 15, 15),
('Five Point Someone', 5, 1, '9788129135492', 2004, 9, 9),
('The Blue Umbrella', 6, 1, '9780143334217', 1980, 6, 6),
('Malgudi Days', 7, 1, '9788185986185', 1943, 11, 11),
('The Da Vinci Code', 8, 3, '9780307474278', 2003, 13, 13),
('Murder on the Orient Express', 9, 3, '9780062693662', 1934, 10, 10),
('Pride and Prejudice', 10, 9, '9781503290563', 1813, 8, 8),
('War and Peace', 11, 6, '9780199232765', 1869, 5, 5),
('Adventures of Tom Sawyer', 12, 1, '9780486400778', 1876, 7, 7),
('Journey to the Center of the Earth', 13, 2, '9780486440880', 1864, 6, 6),
('Sherlock Holmes', 14, 3, '9780141034379', 1892, 9, 9),
('The Kite Runner', 15, 1, '9781594631931', 2003, 10, 10),
('A Tale of Two Cities', 16, 6, '9780486406510', 1859, 8, 8),
('The Shining', 17, 10, '9780307743657', 1977, 6, 6),
('The Hobbit', 18, 4, '9780547928227', 1937, 12, 12);

-- Insert Members
INSERT INTO members (first_name, last_name, email, phone) VALUES
('Rahul', 'Sharma', 'rahul.sharma@email.com', '9876543201'),
('Priya', 'Patel', 'priya.patel@email.com', '9876543202'),
('Amit', 'Verma', 'amit.verma@email.com', '9876543203'),
('Sneha', 'Reddy', 'sneha.reddy@email.com', '9876543204'),
('Arjun', 'Singh', 'arjun.singh@email.com', '9876543205'),
('Neha', 'Gupta', 'neha.gupta@email.com', '9876543206'),
('Karan', 'Mehta', 'karan.mehta@email.com', '9876543207'),
('Anjali', 'Nair', 'anjali.nair@email.com', '9876543208'),
('Vikram', 'Das', 'vikram.das@email.com', '9876543209'),
('Pooja', 'Mishra', 'pooja.mishra@email.com', '9876543210');

-- Insert Book Issues
INSERT INTO book_issues (book_id, member_id, issue_date, due_date, return_date, status) VALUES
(1, 1, '2026-07-01', '2026-07-15', '2026-07-12', 'RETURNED'),
(2, 2, '2026-07-03', '2026-07-17', NULL, 'ISSUED'),
(3, 3, '2026-06-20', '2026-07-04', NULL, 'OVERDUE'),
(4, 4, '2026-07-05', '2026-07-19', '2026-07-18', 'RETURNED'),
(5, 5, '2026-07-08', '2026-07-22', NULL, 'ISSUED'),
(6, 6, '2026-06-25', '2026-07-09', NULL, 'OVERDUE'),
(7, 7, '2026-07-10', '2026-07-24', NULL, 'ISSUED'),
(8, 8, '2026-07-02', '2026-07-16', '2026-07-14', 'RETURNED'),
(9, 9, '2026-07-09', '2026-07-23', NULL, 'ISSUED'),
(10, 10, '2026-06-28', '2026-07-12', NULL, 'OVERDUE');
