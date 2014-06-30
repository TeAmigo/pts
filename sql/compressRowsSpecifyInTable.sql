-- Function: compressrowsspecifyintable(character varying, timestamp without time zone, timestamp without time zone)

-- DROP FUNCTION compressrowsspecifyintable(character varying, timestamp without time zone, timestamp without time zone);

CREATE OR REPLACE FUNCTION compressrowsspecifyintable(IN intab character varying, IN sym character varying, IN begintime timestamp without time zone, IN endtime timestamp without time zone, OUT retrow datedrange_type)
  RETURNS datedrange_type AS
$BODY$
 DECLARE
    selStr text;
    tmpRow datedRange_type%ROWTYPE;
    curs1 refcursor;
    BEGIN
       -- selStr = 'SELECT datetime, open, high, low, close, volume FROM ' || intab || ' where symbol= ' || sym ||
       -- ' and datetime >= ' || beginTime || ' and datetime < ' || endTime || ' order by datetime;';
       OPEN curs1 SCROLL FOR EXECUTE
          'SELECT datetime, open, high, low, close, volume FROM ' || intab::regclass ||
          ' where symbol= ''' || sym || ''' and datetime >= ''' || beginTime || ''' and datetime < '''
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
ALTER FUNCTION compressrowsspecifyintable(regclass, character varying, timestamp without time zone, timestamp without time zone)
  OWNER TO rickcharon;
