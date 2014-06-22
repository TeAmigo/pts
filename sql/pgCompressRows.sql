--- <2010-12-07 Tue 17:58> The Table compression functions for
--- creating e.g., an hour table out of a minute table


-- Function: compressrows(character varying, timestamp without time zone, timestamp without time zone)

-- DROP FUNCTION compressrows(character varying, timestamp without time zone, timestamp without time zone);
-- <2011-11-14 Mon 14:04> Updated to include the quotes around "close" (Keyword collision)
CREATE OR REPLACE FUNCTION compressrows(IN sym character varying, IN begintime timestamp without time zone, IN endtime timestamp without time zone, OUT retrow datedrange_type)
  RETURNS datedrange_type AS
$BODY$
 DECLARE
    tmpRow datedRange_type%ROWTYPE;
    curs1 refcursor;
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
          retRow."close" = tmpRow."close";
          end loop;
    END
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION compressrows(character varying, timestamp without time zone, timestamp without time zone) OWNER TO rickcharon;


------------------------------------------------------------------------------------------------------------
----////  T E S T S ////----
select * from compressRows('AUD', '2009-12-09 03:00:00', '2009-12-09 03:05:00');

SELECT datetime, open, high, low, close, volume FROM quotes1min
      where symbol='AUD' AND datetime >= '2009-12-09 14:00:00' AND datetime < '2009-12-09 15:00:00'
       order by datetime;


select * from createCompressedTable('AUD', '2011-03-25 23:00:00', '2011-03-27 23:00:00', 60);
------------------------------------------------------------------------------------------------------------
----////  E N D  T E S T S ////----




CREATE OR REPLACE FUNCTION createCompressedTable(sym character varying, beginTime timestamp,
                                                 endTime timestamp, compressionFactor int)
   RETURNS SETOF datedRange_type AS
$$
DECLARE
   retrow datedRange_type;
   curs1 refcursor;
   beginDateTime timestamp;
   endDateTime timestamp;
BEGIN
    OPEN curs1 SCROLL FOR EXECUTE 'SELECT CAST(generate_series(CAST(''' || beginTime || ''' As timestamp), 
    CAST(''' || endTime || ''' As timestamp), ''' || compressionFactor || ' minutes'') as timestamp)';
    FETCH curs1 INTO beginDateTime;
    LOOP
       FETCH curs1 INTO endDateTime;
       if not found then
          exit ;
       end if;
      select * into retrow from compressRows(sym, beginDateTime, endDateTime);
      beginDateTime = endDateTime;
      RETURN NEXT retrow;
    END LOOP;
    RETURN;
END;
$$ LANGUAGE plpgsql;



---------------------------------------------------------------------------------------
-- This gives the series of time intervals

select * from createCompressedTimeSeries('2009-12-09 03:00:00', '2009-12-09 15:00:00', 60);

CREATE OR REPLACE FUNCTION createCompressedTimeSeries(beginTime timestamp,
                                          endTime timestamp, compressionFactor int)
   RETURNS SETOF timestamp AS
$$
DECLARE
   retrow timestamp;
BEGIN
   FOR retRow in EXECUTE 'SELECT CAST(generate_series(CAST(''' || beginTime || ''' As timestamp), 
    CAST(''' || endTime || ''' As timestamp), ''' || compressionFactor || ' minutes'') as timestamp)' LOOP
      RETURN NEXT retRow;
   END LOOP;
   RETURN;
END;
$$ LANGUAGE plpgsql;

select * from testTimeSeries('2009-12-09 03:00:00', '2009-12-09 15:00:00', 60);

SELECT CAST(generate_series(CAST('2009-12-09 03:00:00' As timestamp), 
    CAST('2009-12-09 15:00:00' As timestamp), '60 minutes') as timestamp);


--------------------------------------------------------------------------------
--- compress a set of rows into one, assumes they are ordered with earliest time first
-- possible assistance
-- file:///usr/share/doc/postgresql-doc-8.4/html/xfunc-sql.html
--- http://solumslekt.org/blog/
--- http://wiki.postgresql.org/wiki/Main_Page


select * from createCompressedTable('AUD', '2011-04-09 00:00:00.0', '2011-04-18 13:00:00.0', 60 * 24);

select * from compressRows('AUD', '2011-04-09 00:00:00', '2011-04-10 00:00:00');
select * from compressRows('AUD', '2011-04-10 00:00:00', '2011-04-11 00:00:00');
select * from compressRows('AUD', '2011-04-17 00:00:00', '2011-04-18 00:00:00');

select * from createCompressedTable('AUD', '2011-04-09 00:00:00.0', '2011-04-20T15:40:40.901-07:00', 60 * 24);
Need to add a day to the end datetime
SELECT CAST(generate_series(CAST( '2011-04-09 00:00:00.0' As timestamp), 
    CAST('2011-04-18 13:00:00.0' As timestamp), '1440  minutes') as timestamp);
