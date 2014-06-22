----------------------------------------------------------------------
-- File path:     /share/sql/pgUpdateDownload.sql
-- Version:       
-- Description:   Stuff to aid in the independent download of quotes data, 
-- Author:        Rick Charon <rickcharon@gmail.com>
-- Created at:    Thu Jan 13 15:25:06 2011
-- Modified at:   Mon Jan 17 17:38:53 2011
----------------------------------------------------------------------

-- Gets em all!


SELECT symbol,max(datetime) as maxDate, max(expiry)
      as maxExpiry FROM quotes1min group by symbol order by symbol;

SELECT symbol,max(datetime) as maxDate, max(expiry)
      as maxExpiry FROM quotes1min group by symbol order by symbol; 3.5 secs
SELECT exchange FROM futuresContractDetails WHERE symbol= 'AUD' and expiry= 20110314; .1 sec



CREATE TYPE symbolMaxDateLastExpiry AS
   (symbol character varying(8),
    maxdate timestamp without time zone,
    maxexpiry integer
    );

CREATE OR REPLACE FUNCTION symbolMaxDateLastExpiryList()
  RETURNS SETOF symbolMaxDateLastExpiry  AS
$BODY$
  SELECT symbol,max(datetime) as maxDate, max(expiry)
      as maxExpiry FROM quotes1min group by symbol order by symbol;
$BODY$
  LANGUAGE 'sql';

select * from symbolMaxDateLastExpiryList();



-- <2011-01-17 Mon 14:42> This works but is rediculously time consuming, better to
-- use 2 seperate queries, instead of the join
-- SELECT q.symbol, f.exchange, max(q.datetime) as maxDate, max(q.expiry) as maxExpiry 
--  FROM  quotes1min as q, futuresContractDetails as f WHERE f.symbol = q.symbol
--  group by q.symbol, f.exchange order by q.symbol;

-- CREATE OR REPLACE FUNCTION symExchangeMaxDateLastExpiryList()
--   RETURNS SETOF  symExchangeMaxDateLastExpiry AS
-- $BODY$
--   SELECT q.symbol, f.exchange, max(q.datetime) as maxDate, max(q.expiry) as maxExpiry 
--     FROM  quotes1min as q, futuresContractDetails as f WHERE f.symbol = q.symbol
--    group by q.symbol, f.exchange order by q.symbol;
-- $BODY$
--   LANGUAGE 'sql';



select distinct symbol, exchange from futurescontractdetails;



select max(datetime) from quotes1min where symbol = 'ZB';
