----------------------------------------------------------------------
-- File path:     /share/sql/pgPlayItForward.sql
-- Version:       
-- Description:   <2011-01-07 Fri 10:16> Going to extend this to include a function that inserts
--                into the papertrades table
--                Run a trade forward, looking for a high or low that hit conditions, 
-- Author:        Rick Charon <rickcharon@gmail.com>
-- Created at:    Wed Dec 29 10:35:40 2010
-- Modified at:   Fri Jan  7 12:24:10 2011
----------------------------------------------------------------------

--DROP FUNCTION playitforward2(character varying, timestamp without time zone, numeric, numeric, numeric);

   --<2011-01-07 Fri 12:23> This is to do an insert as well, dropping for now
CREATE OR REPLACE FUNCTION playitforward2(symbol character varying,
                                          beginDT timestamp,
                                          entryPrice numeric,
                                          highTarget numeric,
                                          lowTarget numeric)
   RETURNS timestamp    --TABLE(enteredindb timestamp without time zone)

AS $$
DECLARE
   tmpRow datedRange_type%ROWTYPE;
   BEGIN
      select * into tmpRow from playitforward('AUD', '2010-01-03', 0.90, 0.88);

      EXECUTE 'INSERT INTO papertrades(enteredindb, begintradedatetime, symbol, position, entry, 
            stoploss, stoprisk, stopprofit, profitpotential, outcome, exittradedatetime)
    VALUES (?, ?, ?, ?, ?, ?, 
            ?, ?, ?, ?, ?, ?);

      return tmpRow.datetime; --query select enteredindb from papertrades;
   END;
$$ LANGUAGE plpgsql;
         

select * from playitforward2('AUD', '2010-01-03', 0.89, 0.90, 0.88);






----------------------------------------------------------------------
-- Function: playitforward(character varying, timestamp without time zone, numeric, numeric)
-- DROP FUNCTION playitforward(character varying, timestamp without time zone, numeric, numeric);


CREATE OR REPLACE FUNCTION playitforward(character varying, timestamp, numeric, numeric)
   returns datedRange_type
AS
$BODY$
  SELECT datetime, open, high, low, close, volume FROM quotes1min
   where symbol= $1 and datetime > $2 and (high >= $3 or low <=  $4) order by
   datetime limit 1;
$BODY$ LANGUAGE sql;


------------------------ TESTS ----------------------------------------------------------------


SELECT datetime, open, high, low, close, volume FROM quotes1min
   where symbol= 'AUD' and datetime > '2010-01-03' and datetime < '2010-01-05' order by datetime;

SELECT datetime, open, high, low, close, volume FROM quotes1min
   where symbol= 'AUD' and datetime > '2010-01-03' and (high >= 0.90 or low <= 0.88) order by
   datetime limit 1;

select * from playitforward('AUD', '2010-01-03', 0.90, 0.88);

SELECT datetime, open, high, low, close, volume FROM quotes1min
   where symbol= 'AUD' and datetime > '2010-01-03' and (high >= 0.95 or low <= 0.88) order by datetime limit 1;

select * from playitforward('AUD', '2010-03-03 01:09:39.575', 0.905, 0.893);

select * from playitforward('ES', '2009-05-04 00:22', 903.490718521928, 876.277586126742);



PREPARE pif(character varying, timestamp, numeric, numeric) AS
SELECT datetime, open, high, low, close, volume FROM quotes1min
   where symbol= $1 and datetime > $2 and (high >= $3 or low <=  $4) order by
   datetime limit 1;
EXECUTE pif('AUD', '2010-03-03 01:09:39.575', 0.905, 0.893);
