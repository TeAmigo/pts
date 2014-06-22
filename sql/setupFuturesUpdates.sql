-- Step 1:  Execute the following query, returns a list of symbols and current max expiry from
-- quotes-db
SELECT symbol, max(expiry) as exp, min(datetime) as minDate, max(datetime) as maxDate
           FROM quotes1min group by symbol order by exp;

-- Step 2: Set up a query that returns the next expiries for the symbols that need to have updated
-- max expiry
-- <2012-04-12 Thu 08:59> ('ZF', 'ZS', 'GC', 'CL') was last, replacing with 'JPY', 'AUD', 'GBP', 'EUR', 'CL ', 'CAD'

SELECT distinct symbol, expiry, exchange
    FROM futuresContractDetails
   where symbol in ('JPY', 'AUD', 'GBP', 'EUR', 'CL', 'CAD') and expiry >= 20120401 and expiry <= 20120901
   order by symbol, expiry;


  SELECT distinct symbol, expiry, exchange FROM futuresContractDetails
   where symbol in ('ZC', 'ZS', 'ZW', 'ZB', 'ZN')  and expiry >= 20120315 and expiry <= 20120900 order by symbol,expiry;

-- <2013-11-18 Mon 16:42> Get rid of a bad entry   
select * from quotes1min where symbol = 'ZS' and datetime > '2011-12-22 23:59:00' and datetime < '2011-12-24';

delete from quotes1min where symbol = 'ZS' and datetime = '2011-12-23 13:59:00';
----- 

