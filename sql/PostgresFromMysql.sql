-- <2010-11-14 Sun 16:56> rpc - For testing purposes
-- \c Trading   that switches to Trading db


-- <2011-06-11 Sat 15:16> This is the latest move of data from MySql                             
--drop table quotes1minags;

  CREATE TABLE quotes1minEnergy (
  symbol varchar(15) NOT NULL,
  expiry integer NOT NULL,
  datetime timestamp NOT NULL,
  open numeric NOT NULL,
  high numeric NOT NULL,
  low numeric NOT NULL,
  close numeric NOT NULL,
  volume bigint NOT NULL,
  PRIMARY KEY (symbol,datetime)
);

COPY quotes1minEnergy FROM '/share/sql/notSql/quotes1minEnergy.csv' USING DELIMITERS '|' WITH NULL AS 'NULL';
-- message back - COPY 718870

INSERT INTO quotes1min (SELECT * FROM quotes1minenergy);


-- Replaced double with numeric, recm'd for monetary types
CREATE TABLE quotes1min (
  symbol varchar(15) NOT NULL,
  expiry integer NOT NULL,
  datetime timestamp NOT NULL,
  open numeric NOT NULL,
  high numeric NOT NULL,
  low numeric NOT NULL,
  close numeric NOT NULL,
  volume bigint NOT NULL,
  PRIMARY KEY (symbol,datetime)
);

CREATE  PROCEDURE distinctQuoteSymbols
BEGIN
	select DISTINCT symbol from quotes1min;
END;

-- Set delimiter to '|' and null values to 'NULL' in csv export in PhpMySql
COPY quotes1min FROM '/share/sql/quotes1min.csv' USING DELIMITERS '|' WITH NULL AS 'NULL';
-- 1,000,000 rows from row 0
COPY quotes1min FROM '/share/sql/quotes1min0-1mil.csv' USING DELIMITERS '|' WITH NULL AS 'NULL';
-- 1,000,000 rows from row 1,000,000
COPY quotes1min FROM '/share/sql/quotes1min1mil-1mil.csv' USING DELIMITERS '|' WITH NULL AS 'NULL';
-- check
select * from quotes1min where symbol = 'AUD' and datetime = '2010-01-07 08:22';
-- 1,000,000 rows from row 2,000,000
COPY quotes1min FROM '/share/sql/quotes1min2mil-1mil.csv' USING DELIMITERS '|' WITH NULL AS 'NULL';
-- 1,000,000 rows from row 3,000,000
COPY quotes1min FROM '/share/sql/quotes1min3mil-1mil.csv' USING DELIMITERS '|' WITH NULL AS 'NULL';
-- 1,000,000 rows from row 4,000,000
COPY quotes1min FROM '/share/sql/quotes1min4mil-1mil.csv' USING DELIMITERS '|' WITH NULL AS 'NULL';
-- 1,000,000 rows from row 5,000,000
COPY quotes1min FROM '/share/sql/quotes1min5mil-1mil.csv' USING DELIMITERS '|' WITH NULL AS 'NULL';
-- 1,000,000 rows from row 6,000,000
COPY quotes1min FROM '/share/sql/quotes1min6mil-1mil.csv' USING DELIMITERS '|' WITH NULL AS 'NULL';

------------------------------------------------------------------------------------------------------

CREATE TABLE futuresContractDetails (
  symbol varchar(8) NOT NULL,
  expiry integer NOT NULL,
  multiplier integer NOT NULL,
  priceMagnifier integer NOT NULL,
  exchange varchar(8) NOT NULL,
  minTick numeric NOT NULL,
  beginDate date NOT NULL DEFAULT '1900-01-01',
  endDate date NOT NULL DEFAULT '1900-01-01',
  active bit(1) NOT NULL DEFAULT b'0',
  fullName varchar(56) NOT NULL,
  PRIMARY KEY (symbol,expiry)
);

COPY futuresContractDetails FROM '/share/sql/futuresContractDetails.csv' USING DELIMITERS '|' WITH NULL AS 'NULL';

------------------------------------------------------------------------------------------------------

CREATE TABLE IBcard (
  num integer NOT NULL,
  code varchar(4) NOT NULL,
  PRIMARY KEY (num)
);

COPY IBcard FROM '/share/sql/IBcard.csv' USING DELIMITERS '|' WITH NULL AS 'NULL';

-----------------------------------------------------------------------------------------------------
CREATE TYPE status AS
ENUM('PendingSubmit','PendingCancel','PreSubmitted','Submitted','Cancelled','Filled','Inactive');


CREATE TABLE PaperOrders (
  idx serial,
  UL varchar(12) NOT NULL,
  Expiry int NOT NULL,
  BuySell varchar(8) NOT NULL,
  TotalQuantity int NOT NULL DEFAULT '0',
  FilledQuantity int NOT NULL DEFAULT '0',
  RemainingQuantity int DEFAULT '0',
  LimitPrice numeric NOT NULL DEFAULT '0',
  Auxprice numeric NOT NULL DEFAULT '0',
  AvgFillPrice numeric NOT NULL DEFAULT '0',
  OrderType varchar(8) NOT NULL,
  TIF varchar(8) NOT NULL,
  TranslatedPrice numeric NOT NULL,
  BarTime timestamp NOT NULL,
  LossOrGain numeric DEFAULT NULL,
  OCAGroup varchar(24) DEFAULT NULL,
  OcaType smallint DEFAULT '2',
  OrderID int NOT NULL,
  ParentID int DEFAULT NULL,
  PermID int DEFAULT NULL,
  EntryTimestamp timestamp NOT NULL,
  ExecutedTimestamp timestamp DEFAULT NULL,
  Status status NOT NULL DEFAULT 'PendingSubmit',
  PRIMARY KEY (idx)
);

COPY PaperOrders FROM '/share/sql/PaperOrders.csv' USING DELIMITERS '|' WITH NULL AS 'NULL';

-----------------------------------------------------------------------------------------

create TYPE buysellpos as ENUM('BUY','SELL');
drop type position;

CREATE TABLE PaperTrades (
  id serial,
  EnteredInDB timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  BeginTradeDateTime timestamp NOT NULL,
  symbol varchar(12) NOT NULL,
  Position buysellpos NOT NULL,
  entry numeric NOT NULL,
  stoploss numeric NOT NULL,
  stoprisk numeric NOT NULL,
  Stopprofit numeric NOT NULL,
  profitpotential numeric NOT NULL,
  Outcome numeric NOT NULL,
  ExitTradeDateTime timestamp NOT NULL,
  PRIMARY KEY (id)
);

COPY PaperTrades FROM '/share/sql/PaperTrades.csv' USING DELIMITERS '|' WITH NULL AS 'NULL';

---------------------------------------------------------------------------------------------

CREATE TABLE TradesAndResults (
  InDateTime timestamp NOT NULL,
  symbol varchar(12) NOT NULL,
  Position varchar(12) NOT NULL,
  entry numeric DEFAULT NULL,
  stoploss numeric DEFAULT NULL,
  stoprisk numeric DEFAULT NULL,
  Stopprofit numeric DEFAULT NULL,
  profitpotential numeric DEFAULT NULL,
  Outcome numeric DEFAULT NULL,
  OutDateTime timestamp DEFAULT NULL,
  PRIMARY KEY (InDateTime,symbol)
);

COPY  TradesAndResults FROM '/share/sql/TradesAndResults.csv' USING DELIMITERS '|' WITH NULL AS 'NULL';

------------------------------------------------------------------------------------------------

CREATE TABLE Trades (
  UL varchar(12) NOT NULL,
  Expiry int NOT NULL,
  BuySell varchar(8) NOT NULL,
  Quantity int NOT NULL,
  Price numeric NOT NULL,
  Type varchar(8) NOT NULL,
  TIF varchar(8) NOT NULL,
  TranslatedPrice numeric NOT NULL,
  BarTime timestamp NOT NULL,
  LossOrGain numeric DEFAULT NULL,
  OCAGroup varchar(24) DEFAULT NULL,
  OrderID int NOT NULL,
  ParentID int DEFAULT NULL,
  PermID int DEFAULT NULL,
  EntryDateTime timestamp NOT NULL,
  PRIMARY KEY (UL,Expiry,EntryDateTime)
);


CREATE TABLE delicious (
  id serial,
  url text,
  description text,
  extended text,
  tags text,
  date timestamp DEFAULT NULL,
  hash varchar(255) DEFAULT NULL,
  PRIMARY KEY (id)
);

CREATE INDEX date on delicious(date);