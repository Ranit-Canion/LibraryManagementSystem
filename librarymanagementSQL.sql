-- 1. Create Database
CREATE DATABASE LibraryDB;
USE LibraryDB;

-- 2. Create Books Table
CREATE TABLE Books (
    BookID INT PRIMARY KEY,
    Title VARCHAR(100) NOT NULL,
    Author VARCHAR(100),
    Status VARCHAR(20) DEFAULT 'Available' -- Available / Borrowed
);

-- 3. Create Members Table
CREATE TABLE Members (
    MemberID INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE
);

-- 4. Create Transactions Table
CREATE TABLE Transactions (
    TransactionID INT AUTO_INCREMENT PRIMARY KEY,
    BookID INT,
    MemberID INT,
    BorrowDate DATE,
    ReturnDate DATE,
    FOREIGN KEY (BookID) REFERENCES Books(BookID),
    FOREIGN KEY (MemberID) REFERENCES Members(MemberID)
);

-- 5. Insert Sample Books
INSERT INTO Books (BookID, Title, Author) VALUES
(1, 'The Great Gatsby', 'F. Scott Fitzgerald'),
(2, '1984', 'George Orwell'),
(3, 'To Kill a Mockingbird', 'Harper Lee');

-- 6. Insert Sample Members
INSERT INTO Members (MemberID, Name, Email) VALUES
(101, 'Ramit Sen', 'ramit@example.com'),
(102, 'Priya Sharma', 'priya@example.com');

-- 7. Borrow a Book (Transaction + Update Book Status)
INSERT INTO Transactions (BookID, MemberID, BorrowDate)
VALUES (1, 101, CURDATE());

UPDATE Books
SET Status = 'Borrowed'
WHERE BookID = 1;

-- 8. Return a Book
UPDATE Transactions
SET ReturnDate = CURDATE()
WHERE BookID = 1 AND MemberID = 101 AND ReturnDate IS NULL;

UPDATE Books
SET Status = 'Available'
WHERE BookID = 1;

-- 9. View All Books
SELECT * FROM Books;

-- 10. View Borrowed Books
SELECT B.BookID, B.Title, M.Name, T.BorrowDate, T.ReturnDate
FROM Transactions T
JOIN Books B ON T.BookID = B.BookID
JOIN Members M ON T.MemberID = M.MemberID
WHERE B.Status = 'Borrowed';
