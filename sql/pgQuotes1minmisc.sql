----------------------------------------------------------------------
-- File path:     /share/sql/pgQuotes1minmisc.sql
-- Version:       
-- Description:   Misc
-- Author:        Rick Charon <rickcharon@gmail.com>
-- Created at:    Tue Feb 22 12:56:17 2011
-- Modified at:   Mon Jun 23 12:05:46 2014
----------------------------------------------------------------------

-- <2011-06-11 Sat 15:20> Copied over past data for Ags ZS and ZW from MySql, see

-- /share/sql/PostgresFromMysql.sql
INSERT INTO quotes1min_all

select * from quotes1min where not exists
       ( select * from quotes1min_all where symbol = quotes1min.symbol and datetime =quotes1min.datetime );

CREATE TABLE quotes1min_recent AS SELECT * FROM quotes1min WHERE datetime >= '2014-01-01';

SELECT symbol,  max(expiry) as maxexpiry, min(datetime) as minDate, max(datetime) as maxDate
    FROM quotes1min group by symbol order by maxexpiry;

SELECT max(expiry) FROM quotes1min where symbol = 'GC';

select symbol, volume, datetime from quotes1min where symbol = 'ZW' and datetime < '2009-05-05' and
datetime > '2009-05-03';

SELECT count(*) FROM quotes1min;

SELECT symbol,  max(expiry) as maxexpiry, min(datetime) as minDate, max(datetime) as maxDate
    FROM quotes1min group by symbol order by maxexpiry;

SELECT symbol, max(expiry) as maxexpiry
    FROM quotes1min group by symbol order by maxexpiry;

SELECT symbol, max(expiry) as maxexpiry
    FROM quotes1min group by symbol order by symbol;


SELECT symbol, expiry as exp, min(datetime) as minDate, max(datetime) as maxDate
    FROM quotes1min where symbol = 'ZS' group by symbol, expiry order by symbol, expiry;


SELECT symbol, expiry as exp, min(datetime) as minDate, max(datetime) as maxDate
    FROM quotes1min where symbol = 'CL' and expiry in (20110822, 20110720) group by symbol, expiry;


select max(expiry) from quotes1min where symbol = 'CL';
select min(datetime), max(datetime) from quotes1min where symbol = 'CL';



INSERT INTO quotes1min (select * from quotes1minags);

SELECT symbol, max(expiry) as exp, min(datetime) as minDate, max(datetime) as maxDate
    FROM quotes1min group by symbol order by exp;

SELECT symbol, datetime, open * 100000, high * 100000, low * 100000, close * 100000
   FROM quotes1min where symbol = 'ES' and datetime > '2011-04-04T00:00'
                                        and datetime < '2011-04-04T23:00';

SELECT symbol, datetime, open * 100000, high * 100000, low * 100000, close * 100000
   FROM quotes1min where symbol = 'AUD' and datetime = '2011-04-14T00:00'
                                        and datetime < '2011-04-04T23:00';


select distinct symbol from quotes1min order by symbol;

select symbol, multiplier, pricemagnifier from activeFuturesDetails();

select max(datetime) from quotes1min where symbol = 'ES';

DELETE from quotes1min WHERE symbol = 'Zw';
DELETE from quotes1min WHERE symbol in ('NG', 'HO');


--<2012-02-29 Wed 11:52> Below is easiest way to create table from another table, 1 line and WAH-LA!
create table quotes1mindx as select * from quotes1min where symbol='DX'
DELETE from quotes1min WHERE symbol = 'DX';

CREATE TABLE quotes1mindx (
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

                                                             
INSERT INTO quotes1mindx (SELECT * FROM quotes1min where symbol = 'DX');
DELETE from quotes1min WHERE symbol = 'DX';
