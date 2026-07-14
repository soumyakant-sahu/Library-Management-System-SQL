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