-- NOTE!
-- id must always be int UNSIGNED NOT NULL (add AUTO_INCREMENT for PK)
-- money is stored as decimal(15, 2) UNSIGNED
-- popular choice for money is (19, 4) but we don't need that precision right?

DROP TABLE IF EXISTS User;
CREATE TABLE User (
userID int UNSIGNED NOT NULL AUTO_INCREMENT,
nameUser varchar(20),
address varchar(50) default NULL,
email varchar(50) NOT NULL, -- compulsory
phone varchar(20) default NULL,
PRIMARY KEY (userID),
UNIQUE (email)
)
ENGINE=InnoDB DEFAULT CHARSET=latin1;


-- user can create multiple separate accounts
DROP TABLE IF EXISTS Account;
CREATE TABLE Account (
accID int UNSIGNED NOT NULL AUTO_INCREMENT,
userID int UNSIGNED NOT NULL,
username varchar(20) BINARY NOT NULL, -- case sensitive
pword varchar(50) BINARY NOT NULL,		-- case sensitive
rating int DEFAULT 0,
PRIMARY KEY (accID),
UNIQUE (username),
FOREIGN KEY (userID) REFERENCES User(userID)
)
ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS Staff;
CREATE TABLE Staff (
staffID int UNSIGNED NOT NULL AUTO_INCREMENT,
isRep bit NOT NULL,  -- 1 representative, 0 admin
PRIMARY KEY (staffID)
)
ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS Email;
CREATE TABLE Email (
emailID int UNSIGNED NOT NULL AUTO_INCREMENT,
accID int UNSIGNED NOT NULL,
staffID int UNSIGNED DEFAULT 0,  -- default for auto-generated email (notification, etc.)
subject varchar(50),
timeSent datetime DEFAULT CURRENT_TIMESTAMP,
content text,
PRIMARY KEY(emailID),
FOREIGN KEY (accID) REFERENCES Account(accID),
FOREIGN KEY (staffID) REFERENCES Staff(staffID)
)
ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS AuctionT;	-- name overlap with db
CREATE TABLE AuctionT (
auctionID int UNSIGNED NOT NULL AUTO_INCREMENT,
accID int UNSIGNED NOT NULL,
isbn varchar(13) NOT NULL,
min_sell decimal(15, 2) UNSIGNED,  
start_date date,
end_date date,
min_bid decimal(15, 2) UNSIGNED DEFAULT 1,  -- include check? can't be $0
PRIMARY KEY (auctionID),
FOREIGN KEY (accID) REFERENCES Account(accID),
FOREIGN KEY (isbn) REFERENCES Books(isbn)   -- add book before auction
)
ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS Bids;
CREATE TABLE Bids (
accID int UNSIGNED NOT NULL,
auctionID int UNSIGNED NOT NULL,
bid_amount decimal(15, 2) UNSIGNED,  -- check no $0?
PRIMARY KEY (auctionID, accID),
FOREIGN KEY (accID) REFERENCES Account(accID),
FOREIGN KEY (auctionID) REFERENCES AuctionT(auctionID)
)
ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS Auto_Bids;
CREATE TABLE Auto_Bids (
accID int UNSIGNED NOT NULL,
auctionID int UNSIGNED NOT NULL,
max_bid decimal(15, 2) UNSIGNED,
PRIMARY KEY (accID, auctionID),
FOREIGN KEY (accID) REFERENCES Account(accID),
FOREIGN KEY (AuctionID) REFERENCES AuctionT(auctionID)
)
ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS Books;
CREATE TABLE Books (
isbn varchar(13) NOT NULL,
publisher varchar(50),
author varchar(50),
title varchar(50),
PRIMARY KEY (isbn)
)
ENGINE=InnoDB DEFAULT CHARSET=latin1;


-- allow multiple genre & awards
DROP TABLE IF EXISTS Genre_Award;
CREATE TABLE Genre_Award (
isbn varchar(13) NOT NULL,
-- fiction
fantasy bit DEFAULT 0,
scifi bit DEFAULT 0,			-- science fiction
thriller bit DEFAULT 0,		-- horror/thriller
comic bit DEFAULT 0,			-- comic/graphic novel
youngAdult bit DEFAULT 0,
drama bit DEFAULT 0,
romance bit DEFAULT 0,
historical bit DEFAULT 0,
-- non-fiction
biography bit DEFAULT 0,
arts bit DEFAULT 0,			-- arts/photography
tech bit DEFAULT 0,			-- technology
food bit DEFAULT 0,			-- cookbook/food
diy bit DEFAULT 0,				-- crafts/diy
outdoor bit DEFAULT 0,
health bit DEFAULT 0,
religion bit DEFAULT 0,
naturalScience bit DEFAULT 0,
socialScience bit DEFAULT 0,

award_title varchar(100),

PRIMARY KEY (isbn),
FOREIGN KEY (isbn) REFERENCES Books(isbn)
)
ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS QnA;
CREATE TABLE QnA (
qID int UNSIGNED NOT NULL AUTO_INCREMENT,
accID int UNSIGNED NOT NULL,
auctionID int UNSIGNED NOT NULL,
question TINYTEXT,
answer TINYTEXT,
qTime datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
aTime datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
PRIMARY KEY (qID),
FOREIGN KEY (auctionID) REFERENCES AuctionT(auctionID),
FOREIGN KEY (accID) REFERENCES Account(accID)
)
ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS Wish;
CREATE TABLE Wish (
wID int UNSIGNED NOT NULL AUTO_INCREMENT,
accID int UNSIGNED NOT NULL,

isbn varchar(13),
publisher varchar(50),
author varchar(50),
title varchar(50),
award_title varchar(100),
minBid decimal(15, 2) UNSIGNED,
maxBid decimal(15, 2) UNSIGNED,

PRIMARY KEY (wID),
FOREIGN KEY (accID) REFERENCES Account(accID)
)
ENGINE=InnoDB DEFAULT CHARSET=latin1;