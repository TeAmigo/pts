
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

-- <2014-06-30 Mon 09:52> This is from
-- file:///usr/share/doc/postgresql-doc-9.3/html/plpgsql-control-structures.html,
-- a upsert command, update or insert as appropriate, 
CREATE FUNCTION merge_db(key INT, data TEXT) RETURNS VOID AS
$$
BEGIN
    LOOP
        -- first try to update the key
        UPDATE db SET b = data WHERE a = key;
        IF found THEN
            RETURN;
        END IF;
        -- not there, so try to insert the key
        -- if someone else inserts the same key concurrently,
        -- we could get a unique-key failure
        BEGIN
            INSERT INTO db(a,b) VALUES (key, data);
            RETURN;
        EXCEPTION WHEN unique_violation THEN
            -- Do nothing, and loop to try the UPDATE again.
        END;
    END LOOP;
END;
$$
LANGUAGE plpgsql;

SELECT merge_db(1, 'david');
SELECT merge_db(1, 'dennis');
