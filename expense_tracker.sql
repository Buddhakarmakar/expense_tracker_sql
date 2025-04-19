create database expense_tracker;
use expense_tracker;
create table users(
user_id        INT AUTO_INCREMENT PRIMARY KEY,
username       VARCHAR(50) UNIQUE NOT NULL,
email          VARCHAR(100) UNIQUE NOT NULL,
password_hash  VARCHAR(255) NOT NULL,
created_at     DATETIME DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO Users (username, email, password_hash)
VALUES 
('alice_walker', 'alice@example.com', '5f4dcc3b5aa765d61d8327deb882cf99'), -- password
('bob_marley', 'bob@example.com', '202cb962ac59075b964b07152d234b70'),   -- 123
('charlie_pace', 'charlie@example.com', '81dc9bdb52d04dc20036dbd8313ed055'), -- 1234
('diana_prince', 'diana@example.com', 'e99a18c428cb38d5f260853678922e03'),  -- abc123
('ethan_hunt', 'ethan@example.com', '21232f297a57a5a743894a0e4a801fc3');    -- admin


create table accounts(
account_id     INT AUTO_INCREMENT PRIMARY KEY,
user_id        INT NOT NULL,
name           VARCHAR(100) NOT NULL,
account_type   ENUM('Cash', 'Bank', 'Credit Card', 'Wallet'),
balance        DECIMAL(12,2) DEFAULT 0.00,
created_at     DATETIME DEFAULT CURRENT_TIMESTAMP,
FOREIGN KEY (user_id) REFERENCES Users(user_id)

);
INSERT INTO Accounts (user_id, name, account_type, balance)
VALUES
(1, 'Personal Wallet', 'Cash', 250.00),
(1, 'HDFC Savings', 'Bank', 15320.50),
(2, 'ICICI Salary Account', 'Bank', 43000.00),
(2, 'Google Pay Wallet', 'Wallet', 450.75),
(3, 'SBI Joint Account', 'Bank', 7890.00),
(3, 'Axis Credit Card', 'Credit Card', -1200.00),
(4, 'Cash in Hand', 'Cash', 500.00),
(4, 'Paytm Wallet', 'Wallet', 90.50),
(5, 'HDFC Credit Card', 'Credit Card', -7800.50),
(5, 'Kotak Savings', 'Bank', 14200.00);


create table categories (
category_id    INT AUTO_INCREMENT PRIMARY KEY,
user_id        INT NOT NULL,
name           VARCHAR(100) NOT NULL ,   -- e.g., "Food", "Travel"
type           ENUM('Income', 'Expense') NOT NULL,
FOREIGN KEY (user_id) REFERENCES Users(user_id)

);
INSERT INTO Categories (user_id, name, type)
VALUES
(1, 'Salary', 'Income'),
(1, 'Freelance', 'Income'),
(1, 'Investments', 'Income'),
(1, 'Food & Dining', 'Expense'),
(1, 'Groceries', 'Expense'),
(1, 'Rent', 'Expense'),
(1, 'Electricity Bill', 'Expense'),
(2, 'Water Bill', 'Expense'),
(2, 'Internet', 'Expense'),
(2, 'Mobile Recharge', 'Expense'),
(2, 'Entertainment', 'Expense'),
(2, 'Fuel', 'Expense'),
(3, 'Shopping', 'Expense'),
(3, 'Gym Membership', 'Expense'),
(3, 'Travel', 'Expense'),
(3, 'Medical', 'Expense'),
(4, 'Side Business', 'Income'),
(4, 'Bonus', 'Income'),
(5, 'Insurance Premium', 'Expense'),
(5, 'Loan EMI', 'Expense');


create table subcategories (
subcategory_id INT AUTO_INCREMENT PRIMARY KEY,
category_id    INT NOT NULL,
name           VARCHAR(100) NOT NULL   ,  -- e.g., "Groceries", "Dining Out", "Fuel", "Flight Tickets"
FOREIGN KEY (category_id) REFERENCES Categories(category_id)
);

INSERT INTO Subcategories (category_id, name)
VALUES
(1, 'Monthly Salary'),
(1, 'Performance Bonus'),
(2, 'Website Projects'),
(2, 'Consulting'),
(3, 'Stock Dividends'),
(3, 'Mutual Funds'),
(4, 'Restaurants'),
(4, 'Cafes'),
(4, 'Fast Food'),
(5, 'Vegetables'),
(5, 'Fruits'),
(5, 'Meat & Seafood'),
(5, 'Beverages'),
(6, 'House Rent'),
(6, 'Garage Rent'),
(7, 'Electricity - Home'),
(7, 'Electricity - Office'),
(8, 'Water Bill - City Corporation'),
(8, 'Water Bill - Private'),
(9, 'Fiber Internet'),
(9, 'DSL Internet'),
(10, 'Prepaid Recharge'),
(10, 'Postpaid Recharge'),
(11, 'Netflix'),
(11, 'Amazon Prime'),
(11, 'YouTube Premium'),
(12, 'Petrol'),
(12, 'Diesel'),
(12, 'CNG'),
(13, 'Clothes'),
(13, 'Accessories'),
(13, 'Shoes'),
(14, 'Gym Subscription'),
(14, 'Yoga Classes'),
(15, 'Flight Tickets'),
(15, 'Train Tickets'),
(15, 'Hotel Bookings'),
(16, 'Pharmacy'),
(16, 'Doctor Visit'),
(16, 'Health Insurance'),
(17, 'Dropshipping Income'),
(17, 'Online Course Sales'),
(18, 'Annual Bonus'),
(19, 'Life Insurance'),
(19, 'Health Insurance'),
(20, 'Personal Loan EMI'),
(20, 'Car Loan EMI');
SELECT subcategory_id FROM Subcategories ORDER BY subcategory_id;

create table transactions(
transaction_id INT AUTO_INCREMENT PRIMARY KEY,
user_id        INT NOT NULL,
account_id     INT NOT NULL,
category_id    INT NOT NULL,
subcategory_id INT,  -- Nullable, only used if a subcategory exists
amount         DECIMAL(12,2) NOT NULL,
transaction_type ENUM('Income', 'Expense') NOT NULL,
note           TEXT,
transaction_date DATETIME NOT NULL,
created_at     DATETIME DEFAULT CURRENT_TIMESTAMP,
FOREIGN KEY (user_id) REFERENCES Users(user_id),
FOREIGN KEY (account_id) REFERENCES Accounts(account_id),
FOREIGN KEY (category_id) REFERENCES Categories(category_id),
FOREIGN KEY (subcategory_id) REFERENCES Subcategories(subcategory_id)
);
INSERT INTO Transactions (user_id, account_id, category_id, subcategory_id, amount, transaction_type, note, transaction_date)
VALUES
(1, 1, 4, 7, 25.50, 'Expense', 'Dinner at a local cafe', '2025-04-01 19:30:00'),
(1, 2, 1, 1, 2000.00, 'Income', 'April Salary Credited', '2025-04-01 08:00:00'),
(1, 1, 5, 11, 320.00, 'Expense', 'Weekly vegetable shopping', '2025-04-03 11:15:00'),
(1, 2, 6, 15, 9500.00, 'Expense', 'Monthly house rent paid', '2025-04-05 09:00:00'),
(2, 3, 2, 3, 1500.00, 'Income', 'Freelance Website Project', '2025-04-02 14:20:00'),
(2, 3, 4, 8, 45.00, 'Expense', 'Coffee at Starbucks', '2025-04-04 18:00:00'),
(2, 4, 9, 18, 999.00, 'Expense', 'New Fiber Internet Subscription', '2025-04-06 12:30:00'),
(2, 4, 12, 12, 2100.00, 'Expense', 'Fuel refill for car', '2025-04-08 10:45:00'),
(3, 5, 3, 6, 600.00, 'Income', 'Mutual Fund Dividend', '2025-04-07 16:00:00'),
(3, 5, 13, 33, 1500.00, 'Expense', 'Bought new shoes', '2025-04-09 15:30:00'),
(3, 6, 14, 14, 799.00, 'Expense', 'Gym membership renewal', '2025-04-10 09:30:00'),
(3, 6, 11, 12, 499.00, 'Expense', 'YouTube Premium Subscription', '2025-04-11 08:45:00'),
(4, 7, 16, 46, 1250.00, 'Expense', 'Doctor visit and medicines', '2025-04-12 17:20:00'),
(4, 7, 17, 45, 3000.00, 'Income', 'Side business dropshipping payout', '2025-04-13 11:00:00'),
(4, 8, 8, 20, 220.00, 'Expense', 'Water bill payment', '2025-04-14 14:00:00'),
(5, 9, 18, 47, 5000.00, 'Income', 'Annual Bonus from Employer', '2025-04-15 09:00:00'),
(5, 9, 19, 46, 1600.00, 'Expense', 'Life Insurance Premium', '2025-04-16 13:00:00'),
(5, 10, 15, 39, 4500.00, 'Expense', 'Flight ticket to Mumbai', '2025-04-17 06:45:00'),
(5, 10, 20, 45, 8500.00, 'Expense', 'Car Loan EMI payment', '2025-04-18 10:30:00'),
(1, 1, 4, 9, 300.00, 'Expense', 'Fast food dinner', '2025-04-19 19:45:00'),
(1, 1, 5, 12, 480.00, 'Expense', 'Fruit market shopping', '2025-04-20 09:30:00'),
(1, 2, 1, 2, 500.00, 'Income', 'Performance bonus credited', '2025-04-20 10:00:00'),
(1, 2, 10, 21, 399.00, 'Expense', 'Mobile recharge - Airtel', '2025-04-21 12:00:00'),
(1, 1, 4, 7, 150.00, 'Expense', 'Lunch at Food Court', '2025-04-22 13:15:00'),
(2, 3, 2, 4, 1200.00, 'Income', 'Freelance consulting fee', '2025-04-22 19:00:00'),
(2, 4, 9, 18, 950.00, 'Expense', 'Internet bill - JioFiber', '2025-04-23 14:30:00'),
(2, 4, 6, 16, 9100.00, 'Expense', 'Garage rent payment', '2025-04-24 10:30:00'),
(3, 5, 3, 5, 400.00, 'Income', 'Stock dividend payout', '2025-04-24 18:30:00'),
(3, 6, 11, 13, 1299.00, 'Expense', 'Amazon Prime subscription', '2025-04-25 07:30:00'),
(3, 6, 12, 12, 1850.00, 'Expense', 'Full tank diesel', '2025-04-25 16:00:00'),
(3, 5, 13, 34, 800.00, 'Expense', 'Accessory shopping', '2025-04-26 11:00:00'),
(4, 7, 17, 44, 2500.00, 'Income', 'Online course sale', '2025-04-26 21:00:00'),
(4, 8, 15, 37, 1200.00, 'Expense', 'Train ticket - Business trip', '2025-04-27 08:30:00'),
(4, 7, 14, 14, 500.00, 'Expense', 'Renewed Yoga Classes', '2025-04-27 19:15:00'),
(4, 8, 8, 20, 195.00, 'Expense', 'Water bill - Local body', '2025-04-28 10:30:00'),
(5, 9, 1, 1, 2000.00, 'Income', 'April salary', '2025-04-28 09:00:00'),
(5, 10, 19, 46, 1600.00, 'Expense', 'Paid Life Insurance premium', '2025-04-28 13:45:00'),
(5, 10, 20, 45, 8700.00, 'Expense', 'Loan EMI payment', '2025-04-29 11:00:00'),
(1, 1, 4, 8, 70.00, 'Expense', 'Evening coffee shop', '2025-04-29 18:20:00'),
(1, 1, 4, 9, 310.00, 'Expense', 'Pizza and wings night', '2025-04-30 20:15:00'),
(2, 3, 2, 4, 2200.00, 'Income', 'Consulting milestone payment', '2025-05-01 15:00:00'),
(2, 4, 12, 12, 2000.00, 'Expense', 'Fuel for long drive', '2025-05-02 09:10:00'),
(3, 5, 6, 15, 9500.00, 'Expense', 'Monthly rent paid', '2025-05-02 10:00:00'),
(3, 6, 11, 12, 399.00, 'Expense', 'Netflix subscription', '2025-05-03 08:30:00'),
(3, 5, 13, 33, 3200.00, 'Expense', 'Shopping - clothes', '2025-05-03 16:45:00'),
(4, 7, 17, 44, 4200.00, 'Income', 'Course sales payout', '2025-05-04 12:00:00'),
(4, 8, 8, 19, 210.00, 'Expense', 'Water bill paid', '2025-05-04 18:10:00'),
(4, 7, 14, 14, 799.00, 'Expense', 'Monthly Gym fee', '2025-05-05 07:45:00'),
(5, 9, 1, 1, 2000.00, 'Income', 'May salary credited', '2025-05-05 09:00:00');


INSERT INTO Transactions (user_id, account_id, category_id, subcategory_id, amount, transaction_type, note, transaction_date)
VALUES
(1, 2, 18, 46, 2000.00, 'Income', 'Yearly stock options payout', '2025-05-06 10:30:00'),
(1, 1, 4, 8, 90.00, 'Expense', 'Cafe latte and croissant', '2025-05-06 17:20:00'),
(2, 3, 2, 4, 3000.00, 'Income', 'Freelance website update fee', '2025-05-07 12:45:00'),
(2, 4, 12, 12, 1600.00, 'Expense', 'Fuel refill', '2025-05-07 14:30:00'),
(3, 5, 6, 16, 9100.00, 'Expense', 'Garage rent paid', '2025-05-08 09:00:00'),
(3, 6, 11, 13, 999.00, 'Expense', 'Amazon Prime subscription', '2025-05-08 19:00:00'),
(3, 5, 13, 35, 1800.00, 'Expense', 'Accessories - Watch', '2025-05-09 13:10:00'),
(4, 7, 17, 44, 5000.00, 'Income', 'Course sales revenue', '2025-05-09 16:30:00'),
(4, 8, 8, 19, 225.00, 'Expense', 'Water utility bill', '2025-05-10 09:40:00'),
(4, 7, 14, 14, 799.00, 'Expense', 'Monthly Gym fee', '2025-05-10 13:00:00'),
(5, 9, 1, 1, 2000.00, 'Income', 'May salary credited', '2025-05-11 09:00:00'),
(5, 10, 19, 46, 1700.00, 'Expense', 'Paid for dentist appointment', '2025-05-12 14:30:00'),
(5, 10, 20, 45, 7650.00, 'Expense', 'Loan EMI payment', '2025-05-13 11:00:00'),
(1, 1, 4, 8, 110.00, 'Expense', 'Evening snacks', '2025-05-14 18:20:00'),
(1, 1, 5, 12, 370.00, 'Expense', 'Vegetables and fruits', '2025-05-14 19:15:00'),
(1, 2, 1, 2, 3200.00, 'Income', 'Freelance video editing', '2025-05-15 10:30:00'),
(2, 3, 2, 4, 2700.00, 'Income', 'Web development contract', '2025-05-15 13:00:00'),
(2, 4, 12, 12, 1750.00, 'Expense', 'Fuel for long drive', '2025-05-16 08:00:00'),
(3, 5, 3, 5, 530.00, 'Income', 'Stock dividend payout', '2025-05-16 14:30:00'),
(3, 5, 13, 33, 1400.00, 'Expense', 'Clothing shopping', '2025-05-17 11:00:00'),
(3, 6, 11, 13, 699.00, 'Expense', 'Amazon subscription renewal', '2025-05-17 16:30:00'),
(4, 7, 16, 45, 1300.00, 'Expense', 'Medical checkup bill', '2025-05-18 12:00:00'),
(4, 7, 17, 44, 3200.00, 'Income', 'Online course income', '2025-05-19 11:00:00'),
(5, 9, 1, 1, 3000.00, 'Income', 'May freelance income', '2025-05-19 09:00:00'),
(5, 10, 19, 47, 1200.00, 'Expense', 'Car insurance renewal', '2025-05-20 14:00:00'),
(5, 10, 20, 46, 4200.00, 'Expense', 'Loan EMI payment', '2025-05-21 10:30:00'),
(1, 1, 4, 9, 80.00, 'Expense', 'Evening snacks', '2025-05-22 17:30:00'),
(1, 1, 5, 12, 550.00, 'Expense', 'Grocery shopping', '2025-05-22 18:00:00'),
(1, 2, 1, 2, 4000.00, 'Income', 'Freelance project work', '2025-05-23 11:30:00'),
(2, 3, 2, 4, 3500.00, 'Income', 'Web development contract', '2025-05-23 14:00:00'),
(2, 4, 12, 12, 1600.00, 'Expense', 'Fuel for car', '2025-05-24 10:00:00'),
(3, 5, 6, 15, 9100.00, 'Expense', 'Monthly rent payment', '2025-05-24 12:15:00'),
(3, 6, 11, 13, 899.00, 'Expense', 'Netflix subscription', '2025-05-25 09:30:00'),
(3, 5, 13, 33, 3200.00, 'Expense', 'Shopping for clothes', '2025-05-25 16:00:00'),
(4, 7, 17, 44, 2500.00, 'Income', 'Online course sale', '2025-05-26 10:00:00'),
(4, 8, 8, 19, 250.00, 'Expense', 'Water bill payment', '2025-05-26 14:45:00'),
(4, 7, 14, 14, 849.00, 'Expense', 'Gym membership fee', '2025-05-27 07:30:00'),
(5, 9, 1, 1, 2500.00, 'Income', 'May salary credited', '2025-05-27 09:00:00'),
(5, 10, 19, 46, 1800.00, 'Expense', 'Paid car servicing bill', '2025-05-28 12:30:00'),
(5, 10, 20, 45, 8700.00, 'Expense', 'Loan EMI payment', '2025-05-29 10:00:00'),
(1, 1, 4, 8, 100.00, 'Expense', 'Evening drink', '2025-05-30 20:00:00'),
(1, 1, 5, 12, 270.00, 'Expense', 'Supermarket purchase', '2025-05-30 21:15:00'),
(1, 2, 1, 2, 2500.00, 'Income', 'Freelance writing project', '2025-05-31 09:00:00'),
(2, 3, 2, 4, 4000.00, 'Income', 'Freelance coding project', '2025-05-31 14:30:00'),
(2, 4, 12, 12, 2000.00, 'Expense', 'Fuel and car maintenance', '2025-06-01 08:00:00'),
(3, 5, 6, 16, 8700.00, 'Expense', 'Monthly rent paid', '2025-06-02 10:30:00'),
(3, 6, 11, 13, 1050.00, 'Expense', 'Spotify subscription', '2025-06-02 15:00:00'),
(3, 5, 13, 33, 2000.00, 'Expense', 'Personal shopping', '2025-06-03 13:30:00'),
(4, 7, 17, 44, 4800.00, 'Income', 'Course income from sales', '2025-06-03 18:30:00'),
(4, 8, 8, 19, 235.00, 'Expense', 'Water utility bill', '2025-06-04 12:00:00'),
(4, 7, 14, 14, 1000.00, 'Expense', 'Personal fitness trainer fee', '2025-06-04 16:30:00'),
(5, 9, 1, 1, 3500.00, 'Income', 'Freelance video production', '2025-06-05 11:00:00'),
(5, 10, 19, 47, 1900.00, 'Expense', 'Home appliance purchase', '2025-06-06 13:00:00'),
(5, 10, 20, 45, 6800.00, 'Expense', 'EMI payment for car loan', '2025-06-07 08:30:00');


select * from transactions; 
select * from users;
select * from categories;
select * from subcategories;
with expenseCTE as( select  u.username , t.transaction_type , t.amount, t.note , t.transaction_date , 
		c.name as category , 
        s.name as sub_category 
        from transactions t 
        inner join users u on u.user_id=t.user_id 
        inner join categories c on c.category_id=t.category_id 
        inner join subcategories s on s.subcategory_id=t.subcategory_id
        )

select * from expenseCTE;

-- total expense for april for user 1
select transaction_type, sum(amount)  from transactions where user_id=1 group by transaction_type;


create table budgets(
budget_id      INT AUTO_INCREMENT PRIMARY KEY,
user_id        INT NOT NULL,
category_id    INT NOT NULL,
amount_limit   DECIMAL(12,2) NOT NULL,
period         ENUM('Daily', 'Weekly', 'Monthly'),
start_date     DATE,
end_date       DATE,
FOREIGN KEY (user_id) REFERENCES Users(user_id),
FOREIGN KEY (category_id) REFERENCES Categories(category_id)

);

