-- <2010-11-16 Tue 15:08> rpc - Only keeping what works

--<2010-11-22 Mon 12:04> rpc - First C function, see notes-postgresql
 \c mydb -- do this in mydb create table 'emp' with id, name, and salary

drop table emp;

CREATE TABLE emp
(
  "name" character varying(32),
  salary int4
);
INSERT INTO emp("name", salary) VALUES ('bill', 1200);
INSERT INTO emp("name", salary) VALUES ('jim', 900);
INSERT INTO emp("name", salary) VALUES ('joe', 1500);
select * from emp;

CREATE FUNCTION overpaid(emp, integer) RETURNS boolean
    AS '$libdir/funcs/overpaid', 'overpaid'
    LANGUAGE C STRICT;

SELECT name, overpaid(emp, 1000) AS overpaid
    FROM emp
    WHERE name = 'bill' OR name = 'joe';    


 

---------------------------------------------------------------------------
-- All these work
CREATE FUNCTION add_one(integer) RETURNS integer
    AS '$libdir/funcs/add_one', 'add_one'
    LANGUAGE C STRICT;

SELECT add_one(3);

CREATE FUNCTION copytext(text) RETURNS text
     AS '$libdir/funcs/copytext', 'copytext'
     LANGUAGE C STRICT;

select copytext('This is a string');

CREATE FUNCTION concat_text(text, text) RETURNS text
     AS '$libdir/funcs/concat_text', 'concat_text'
     LANGUAGE C STRICT;

select concat_text('This is front ', 'and rear of string');     





---------------------------------------------------------------------------------------

CREATE FUNCTION sales_tax(subtotal real, OUT tax real) AS $$
BEGIN
tax := subtotal * 0.06;
END;
$$ LANGUAGE plpgsql;

---------------------------------------------------------

CREATE FUNCTION HOWMANYQUOTES() RETURNS int AS $$
DECLARE
  qty int;
BEGIN  
   SELECT count(*) into qty from quotes1min;
   return qty;
END;
$$ LANGUAGE plpgsql;

select howmanyquotes();

---------------------------------------------------------

create function fcd()  RETURNS SETOF futurescontractdetails AS $$
 select * from futurescontractdetails;
$$ LANGUAGE SQL;

select fcd();

---------------------------------------------------------

create or replace function distinctQuoteSymbols() returns table(symbol text)
AS $$ select distinct symbol from quotes1min order by symbol;
$$ LANGUAGE SQL;

select * from  distinctQuoteSymbols();

---------------------------------------------------------

select distinct symbol from quotes1min;

----------------------------------------------------------------------

-- Next 2 were needed to get everything corrected.
drop function datedRangeBySymbol(text, timestamp, timeStamp);
drop TYPE datedRange_type;

---- Needed as return type from datedRangeBySymbol function
CREATE TYPE datedRange_type AS (
datetime timestamp,
open numeric,
high numeric,
low numeric,
close numeric,
volume bigint
);

CREATE OR REPLACE FUNCTION datedRangeBySymbol(varchar, timestamp, timeStamp)
       RETURNS  setof datedRange_type AS $$
SELECT datetime, open, high, low, close, volume FROM quotes1min
WHERE symbol = $1 and datetime >= $2 and datetime <= $3
ORDER BY datetime;
$$ LANGUAGE sql;
-- test it
select * from datedRangeBySymbol('GBP', '2009-12-08 00:00:00', '2009-12-08 00:03:00');

-----------------------------------------------------------------------------------------

-- This is for the
-- [[file:/share/JavaDev/PeTraSys/src/petrasys/runners/PriceBarCompressionToDB.java::/*][PriceBarCompressionToDB]]
---functionality
-- to replace [[file:/share/JavaDev/PeTraSys/src/petrasys/utils/DBops.java::public%20static%20String%20createCompressionTable(int%20compressionFactor)%20{][DBops::createCompressionTable()]]
--

CREATE OR REPLACE FUNCTION createCompressionTable(tableName varchar, factor int) RETURNS void AS  $$
BEGIN
EXECUTE 'CREATE TEMP TABLE ' || tableName ||
' (
  symbol character varying(15) NOT NULL,
  expiry integer NOT NULL,
  datetime timestamp without time zone NOT NULL,
  open numeric NOT NULL,
  high numeric NOT NULL,
  low numeric NOT NULL,
  "close" numeric NOT NULL,
  volume bigint NOT NULL,
  aggregate_number integer,
  CONSTRAINT ' || tableName || '_pkey PRIMARY KEY (symbol, datetime)
);';
END;
$$ LANGUAGE plpgsql;

select createCompressionTable('xyz');\dt
drop table xyz;

--------------------------------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION compressRows(sym character varying, beginTime timestamp,
                                        endTime timestamp, compressionFactor int)
   RETURNS  SETOF datedRange_type AS $$
    DECLARE
       periodBegin, timestamp;
       periodEnd, timestamp;
       --retTab datedRange_type[];
       retRow datedRange_type%ROWTYPE;
    BEGIN
       periodBegin = beginTime;
       --FOR periodEnd in
-- <2010-12-07 Tue 17:26> Working on testTimeSeries in /share/sql/postgresDateTimes.sql to go in here
       -- array_append(retTab, -- INTO retRow
       FOR retRow in EXECUTE 
                     'SELECT datetime, open, high, low, close, volume FROM quotes1min
          where symbol= ''' || sym || ''' and datetime > ''' || beginTime || ''' and datetime <= '''
                     || endTime || ''' order by datetime' LOOP
          RETURN NEXT retRow;
       END LOOP;
       RETURN;
    END
$$ LANGUAGE plpgsql;

         
    
select * from compressRows('AUD', '2009-12-09 03:00:00', '2009-12-09 15:00:00', 1);
SELECT datetime, open, high, low, close, volume FROM quotes1min
      where symbol='AUD' AND datetime > '2009-12-08 00:00:00' AND datetime <= '2009-12-09 00:03:00'
       order by datetime;    

--------------------------------------------------------------------------------------
-- <2010-12-07 Tue 16:39> Example from http://solumslekt.org/blog/
CREATE OR REPLACE FUNCTION filtered_places() RETURNS SETOF places AS $$
DECLARE
    fl RECORD;
    pl places%ROWTYPE;
 
BEGIN
    SELECT
        (SELECT my_val FROM settings WHERE my_key = 'place_filter_level') AS _mkey,
        (SELECT my_val FROM settings WHERE my_key = 'place_filter_content') AS _mval
    INTO fl;
    FOR pl IN EXECUTE 'SELECT * FROM places WHERE ' || fl._mkey ||
            ' LIKE ' || QUOTE_LITERAL(fl._mval) || ' OR place_id = 1' LOOP
        RETURN NEXT pl;
    END LOOP;
    RETURN;
END
$$ LANGUAGE plpgsql STABLE;

------------------------------------------------------------------------