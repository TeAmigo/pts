-- Function: createcompressedtablespecifyintable(character varying, timestamp without time zone, timestamp without time zone, integer)

-- DROP FUNCTION createcompressedtablespecifyintable(character varying, timestamp without time zone, timestamp without time zone, integer);

CREATE OR REPLACE FUNCTION createcompressedtablespecifyintable(intab character varying, sym character varying, begintime timestamp without time zone, endtime timestamp without time zone, compressionfactor integer)
  RETURNS SETOF datedrange_type AS
$BODY$
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
      select * into retrow from compressRowsspecifyintable(intab, sym, beginDateTime, endDateTime);
      beginDateTime = endDateTime;
      RETURN NEXT retrow;
    END LOOP;
    RETURN;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100
  ROWS 1000;
ALTER FUNCTION createcompressedtablespecifyintable(character varying, character varying, timestamp without time zone, timestamp without time zone, integer)
  OWNER TO rickcharon;
