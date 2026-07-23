-- Create Database
CREATE DATABASE IF NOT EXISTS library_management_system;
USE library_management_system;

-- Authors Table
CREATE TABLE authors (
    author_id INT AUTO_INCREMENT PRIMARY KEY,
    author_name VARCHAR(100) NOT NULL,
    country VARCHAR(50)
);

-- Categories Table
CREATE TABLE categories (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(50) UNIQUE NOT NULL
);

-- Books Table
CREATE TABLE books (
    book_id INT AUTO_INCREMENT PRIMARY KEY,

    title VARCHAR(100) NOT NULL,

    author_id INT NOT NULL,
    CONSTRAINT fk_book_author
        FOREIGN KEY (author_id)
        REFERENCES authors(author_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    category_id INT NOT NULL,
    CONSTRAINT fk_book_category
        FOREIGN KEY (category_id)
        REFERENCES categories(category_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    isbn VARCHAR(20) UNIQUE NOT NULL,

    published_year INT NOT NULL,

    total_copies INT NOT NULL,
    available_copies INT NOT NULL,

    CONSTRAINT chk_total_copies
        CHECK(total_copies >= 0),

    CONSTRAINT chk_available_copies
        CHECK(available_copies >= 0),

    CONSTRAINT chk_book_copies
        CHECK(available_copies <= total_copies),

    CONSTRAINT chk_published_year
        CHECK(published_year >= 1000)
);

-- Members Table
CREATE TABLE members (
    member_id INT AUTO_INCREMENT PRIMARY KEY,

    first_name VARCHAR(50) NOT NULL,

    last_name VARCHAR(50) NOT NULL,

    email VARCHAR(100) UNIQUE NOT NULL,

    phone VARCHAR(15) UNIQUE NOT NULL,

    join_date DATE DEFAULT (CURRENT_DATE),

    membership_status ENUM('ACTIVE','INACTIVE')
    DEFAULT 'ACTIVE'
);

-- Book Issues Table
CREATE TABLE book_issues (

    issue_id INT AUTO_INCREMENT PRIMARY KEY,

    book_id INT NOT NULL,

    member_id INT NOT NULL,

    issue_date DATE DEFAULT (CURRENT_DATE),

    due_date DATE NOT NULL,

    return_date DATE,

    status ENUM('ISSUED','RETURNED','OVERDUE')
    DEFAULT 'ISSUED',

    CONSTRAINT fk_issue_book
        FOREIGN KEY(book_id)
        REFERENCES books(book_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT fk_issue_member
        FOREIGN KEY(member_id)
        REFERENCES members(member_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);
