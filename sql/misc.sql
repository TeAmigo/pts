
SELECT pg_database_size(current_database()); -- Guess what?

-- The column ‘ctid’ is a special column available for every tables but not visible unless
-- specifically mentioned.
-- The ctid column value is considered unique for every rows in a table.

DELETE FROM customers WHERE ctid NOT IN
(SELECT max(ctid) FROM customers GROUP BY customers.*) ;


-- http://www.postgresql.org/docs/9.1/static/disk-usage.html
SELECT pg_relation_filepath(oid), relpages, pg_size_pretty(pg_relation_size(oid)) AS "size"
FROM pg_class WHERE relname = 'aud';

-- https://wiki.postgresql.org/wiki/Disk_Usage 
SELECT nspname || '.' || relname AS "relation",
    pg_size_pretty(pg_relation_size(C.oid)) AS "size"
  FROM pg_class C
  LEFT JOIN pg_namespace N ON (N.oid = C.relnamespace)
  WHERE nspname NOT IN ('pg_catalog', 'information_schema')
  ORDER BY pg_relation_size(C.oid) DESC
  LIMIT 20;
  
if(SELECT record exists) { UPDATE record; } else { INSERT record; }

do language plpgsql $$
    begin
           if (select count(*) from aud) > 0 then
            raise notice 'Got some';
        else
            raise notice 'Got none';
        end if;
    end;
$$;



CREATE OR REPLACE FUNCTION upserttest(IN sym character varying(15), IN expire integer,
                                        IN dt timestamp without time zone, IN open numeric,
                                        IN high numeric, IN low numeric, IN close numeric, IN vol
                                        bigint)
                RETURNS VOID AS
$$
-- <2014-06-30 Mon 09:52> This inserts quotes into the quotes tables, checking if the datetime
-- timestamp already exists. If it does, it updates the table, i.e., - new values are put in and old
-- are discarded. This is because it is assumed that any new values are the most desirable, having
-- teh correct expiry wanted for that datetime.
BEGIN
    LOOP
        -- first try to update the key
        UPDATE test SET col2 = data WHERE col1 = key;
        IF found THEN
            RETURN;
        END IF;
        -- not there, so try to insert the key
        -- if someone else inserts the same key concurrently,
        -- we could get a unique-key failure
        BEGIN
            INSERT INTO test(col1, col2) VALUES (key, data);
            RETURN;
        EXCEPTION WHEN unique_violation THEN
            -- Do nothing, and loop to try the UPDATE again.
        END;
    END LOOP;
END;
$$
LANGUAGE plpgsql;

SELECT upsert('123', 'upsert!');
SELECT upsert('789', 'new!');
