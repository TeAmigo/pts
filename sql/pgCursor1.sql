CREATE TABLE test (col text);
INSERT INTO test VALUES ('123');
INSERT INTO test VALUES ('456');

CREATE FUNCTION reffunc(refcursor) RETURNS refcursor AS '
BEGIN
    OPEN $1 FOR SELECT col FROM test;
    RETURN $1;
END;
' LANGUAGE plpgsql;

BEGIN;
SELECT * from reffunc('funccursor');
FETCH ALL IN funccursor;
MOVE FIRST FROM funccursor;
FETCH ALL IN funccursor;
END;
COMMIT;







CREATE OR REPLACE FUNCTION compressRows(sym character varying, beginTime timestamp,
                                        endTime timestamp)
   RETURNS  datedRange_type AS $$
    DECLARE
       retRow datedRange_type%ROWTYPE;
       tmpRow datedRange_type%ROWTYPE;
       curs1 refcursor;
       highOut numeric;
       lowOut numeric;
    BEGIN
       OPEN curs1 SCROLL FOR EXECUTE 
          'SELECT datetime, open, high, low, close, volume FROM quotes1min
          where symbol= ''' || sym || ''' and datetime >= ''' || beginTime || ''' and datetime < '''
          || endTime || ''' order by datetime';
       FETCH curs1 INTO retRow;
       LOOP
          FETCH curs1 INTO tmpRow;
          if not found then
             exit ;
          end if;
          if tmpRow.high > retRow.high then
             retRow.high = tmpRow.high;
             end if;
          if tmpRow.low < retRow.low then
             retRow.low = tmpRow.low;
             end if;
          retRow.volume = retRow.volume + tmpRow.volume;
          retRow.close = tmpRow.close;
          end loop;
       RETURN retRow;
    END
          $$ LANGUAGE plpgsql;

select * from compressRows('AUD', '2009-12-09 03:05:00', '2009-12-09 03:10:00');
SELECT datetime, open, high, low, close, volume FROM quotes1min
      where symbol='AUD' AND datetime >= '2009-12-09 03:05:00' AND datetime < '2009-12-09 03:10:00'
       order by datetime;

-- FOR retRow in EXECUTE 
--                      'SELECT datetime, open, high, low, close, volume FROM quotes1min
--           where symbol= ''' || sym || ''' and datetime > ''' || beginTime || ''' and datetime <= '''
--                      || endTime || ''' order by datetime' LOOP
--           RETURN NEXT retRow;
--      END LOOP;
