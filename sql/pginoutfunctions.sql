----------------------------------------------------------------------
-- File path:     /share/sql/pginoutfunctions.sql
-- Version:       
-- Description:   Figure out what happens with these in, out, and inout params, how they can be
--                accessed , pretty much useless, the output result set is all thats changed, not
--                the inout variable.
-- Author:        Rick Charon <rickcharon@gmail.com>
-- Created at:    Fri Dec 24 15:44:45 2010
-- Modified at:   Fri Dec 31 14:30:40 2010
----------------------------------------------------------------------


CREATE TYPE symbolminmaxdates AS
   ( Symbol character varying ,
     MinDate timestamp without time zone,
     MaxDate timestamp without time zone);


CREATE OR REPLACE FUNCTION MinMaxDateForAll() RETURNS Setof symbolminmaxdates AS
$BODY$
  SELECT symbol, min(datetime) as minDate, max(datetime) as maxDate FROM quotes1min group by symbol;
$BODY$ LANGUAGE 'sql';

select * from MinMaxDateForAll();

CREATE OR REPLACE FUNCTION add1 (inout ain integer) RETURNS integer
AS $$
   BEGIN
      ain = ain + 1;
      return;
   END;
   $$ LANGUAGE plpgsql;

select add1(8);

CREATE OR REPLACE FUNCTION add2 (ain integer) RETURNS integer
AS $$
   DECLARE ii integer;
   BEGIN
      ii = ain;
      perform add1(ii);
      return ii;
   END;
   $$ LANGUAGE plpgsql;

select add2(8);

CREATE OR REPLACE FUNCTION fib(fib_for integer) RETURNS integer
AS $$
   BEGIN
      IF fib_for < 2 THEN
         RETURN fib_for;
      END IF;
      RETURN fib(fib_for - 2) + fib(fib_for - 1);
   END;
   $$ LANGUAGE plpgsql;

select fib(8);   