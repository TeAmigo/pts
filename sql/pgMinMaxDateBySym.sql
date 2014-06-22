----------------------------------------------------------------------
-- File path:     /share/sql/pgMinMaxDateBySym.sql
-- Version:       
-- Description:   List the min/max dates for symbols with data
-- Author:        Rick Charon <rickcharon@gmail.com>
-- Created at:    Wed Dec 29 18:03:05 2010
-- Modified at:   Mon Mar 14 16:35:55 2011
----------------------------------------------------------------------
CREATE TYPE symbolminmaxdates AS
   ( Symbol character varying ,
     MinDate timestamp without time zone,
     MaxDate timestamp without time zone);


CREATE OR REPLACE FUNCTION MinMaxDateForAll() RETURNS Setof symbolminmaxdates AS
$BODY$
  SELECT symbol, min(datetime) as minDate, max(datetime) as maxDate
    FROM quotes1min group by symbol order by symbol;
$BODY$ LANGUAGE 'sql';

select * from MinMaxDateForAll();

SELECT symbol,max(datetime) as maxDate, max(expiry)
      as maxExpiry FROM quotes1min group by symbol order by symbol;

<2011-01-18 Tue 15:56>
 symbol |       mindate       |       maxdate       
--------+---------------------+---------------------
 AUD    | 2009-03-11 00:00:00 | 2011-01-18 15:10:00
 CAD    | 2009-03-12 00:00:00 | 2011-01-18 15:10:00
 DX     | 2009-03-06 00:00:00 | 2011-01-18 14:59:00
 ES     | 2009-03-11 00:00:00 | 2011-01-18 15:10:00
 EUR    | 2009-01-02 03:00:00 | 2011-01-18 15:10:00
 GBP    | 2009-01-08 00:00:00 | 2011-01-18 15:10:00
 JPY    | 2009-01-02 03:00:00 | 2011-01-18 15:11:00
 ZB     | 2009-02-26 00:00:00 | 2011-01-18 13:59:00
 ZF     | 2009-03-01 15:30:00 | 2011-01-18 13:59:00
 ZN     | 2008-12-12 00:00:00 | 2011-01-18 13:59:00
(10 rows)





SELECT symbol, min(datetime) as minDate, max(datetime) as maxDate
    FROM quotes1min group by symbol order by symbol;

<2010-12-30 Thu 14:45> results
 symbol |       mindate       |       maxdate       
--------+---------------------+---------------------
 JPY    | 2009-01-02 03:00:00 | 2010-12-13 17:13:00
 DX     | 2009-03-06 00:00:00 | 2010-12-13 17:13:00
 ES     | 2009-03-11 00:00:00 | 2010-12-13 17:13:00
 ZB     | 2009-02-26 00:00:00 | 2010-12-13 17:13:00
 ZF     | 2009-03-01 15:30:00 | 2010-12-13 17:13:00
 AUD    | 2009-03-11 00:00:00 | 2010-12-13 17:13:00
 ZN     | 2008-12-12 00:00:00 | 2010-12-13 17:14:00
 GBP    | 2009-01-08 00:00:00 | 2010-12-13 17:13:00
 CAD    | 2009-03-12 00:00:00 | 2010-12-13 17:13:00
 EUR    | 2009-01-02 03:00:00 | 2010-12-13 17:13:00
(10 rows)
