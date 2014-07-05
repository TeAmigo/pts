

-- create function Gettables() returns setof futurestables as 'select * from futurestables;' language 'sql';

CREATE TYPE symbolMaxDateLastExpiry2 AS
   (symbol character varying(15),
    maxdate timestamp without time zone,
    maxexpiry integer
    );


CREATE OR REPLACE FUNCTION symbolMaxDateLastExpiryList2()
  RETURNS SETOF symbolMaxDateLastExpiry2  AS
$$
DECLARE
symtab symbolMaxDateLastExpiry2%rowtype;
nameIn character varying(15);
exeStr text;
BEGIN
        FOR nameIn IN SELECT name FROM futurestables
        LOOP
                
                exeStr = 'SELECT symbol,max(datetime) as maxDate, max(expiry) as maxExpiry
                       FROM ' || nameIn::regclass || ' group by symbol order by symbol;';
                -- raise notice '%', exeStr;
                return query execute exeStr;
        END LOOP;
        RETURN;
END;
$$
LANGUAGE plpgsql;
  
select * from symbolMaxDateLastExpiryList2();
