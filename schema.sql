-- Create database 
create database library_management_system;
use library_management_system;


-- create table authors
create table authors(
	author_id int auto_increment primary key,
    author_name varchar(100) not null,
    country varchar(50));


-- create table categories
create table categories(
	category_id int auto_increment primary key,
    category_name varchar(50) unique not null);


-- create table books
create table books(
	book_id int auto_increment primary key,
    title varchar(100) not null,
    author_id int not null,
    constraint fk_book_author
    foreign key(author_id) 
		references authors(author_id),
    category_id int not null,
    constraint fk_book_category
    foreign key(category_id)
		references categories(category_id),
    isbn varchar(20) unique not null,
    published_year year not null,
    total_copies int not null,
    available_copies int not null,
    check(total_copies >=0),
	check (available_copies >= 0),
    check(available_copies <= total_copies)
    );

   -- Create table members
CREATE TABLE members (
    member_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(15) UNIQUE NOT NULL,
    join_date DATE DEFAULT (CURRENT_DATE),
    membership_status ENUM('ACTIVE', 'INACTIVE') DEFAULT 'ACTIVE'
); 

-- Create table book_issues
CREATE TABLE book_issues (
    issue_id INT AUTO_INCREMENT PRIMARY KEY,

    book_id INT NOT NULL,
    member_id INT NOT NULL,

    issue_date DATE DEFAULT (CURRENT_DATE),
    due_date DATE NOT NULL,
    return_date DATE,

    status ENUM('ISSUED', 'RETURNED', 'OVERDUE')
        DEFAULT 'ISSUED',

    CONSTRAINT fk_issue_book
        FOREIGN KEY (book_id)
        REFERENCES books(book_id),

    CONSTRAINT fk_issue_member
        FOREIGN KEY (member_id)
        REFERENCES members(member_id)
);

