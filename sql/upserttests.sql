-- <2014-06-30 Mon 10:52> Want to be able to avoid duplicate datetime rows in quotes db. This can
-- happen when updating to a new expiry, and there is already data for a datetime for an old
-- expiry. Assuming that the new update is the most desirable!

CREATE OR REPLACE FUNCTION upsertquoterow1(IN sym character varying(15))
                RETURNS VOID AS
$$
-- <2014-06-30 Mon 09:52> This inserts quotes into the quotes tables, checking if the datetime
-- timestamp already exists. If it does, it updates the table, i.e., - new values are put in and old
-- are discarded. This is because it is assumed that any new values are the most desirable, having
-- the correct expiry wanted for that datetime.

DECLARE
selStr text;
upStr text;
rowsFound  INTEGER := 0;
BEGIN
        -- upStr = 'UPDATE ' || sym::regclass ||  ' SET symbol = ''' || sym || ''', expiry = ''' || expiry ||
        --         ''', datetime = ''' || dt || ''', open = ''' || open || ''', high = ''' || high || ''', low = '''
        --         || low || ''', close = ''' || close || ''', volume = ''' || vol || ''' WHERE datetime = ''' || dt || ''';';

        -- selStr =  'INSERT INTO ' || sym::regclass || ' (symbol, expiry, datetime, open, high,
        --                                 low, close, volume) 
        --                                 VALUES (''' || sym || ''', ''' || expiry || ''', ''' || dt || ''', ''' || open ||
        --                                 ''', ''' || high || ''', ''' || low || ''', ''' || close || ''', ''' || vol || ''');';
        raise notice '%', sym;
                
        -- raise notice '%', selStr;
        
        -- raise notice '%', upStr;

        -- EXECUTE upStr;
        
        -- 'UPDATE ' || sym::regclass ||  ' SET symbol = ' || sym || ', expiry = ' || expiry ||
        --         ', datetime = ' || dt || ', open = ' || open || ', high = ' || high || ', low = ' || low || ', close = '
        --         || close || ', volume = ' || vol || ' WHERE datetime = ' || dt || ';';
        -- GET DIAGNOSTICS rowsFound = ROW_COUNT;
        -- raise notice 'Found rows: %', rowsFound;
        -- Note that sample in docs uses found condition, but that doesn't work when using EXECUTE statement.
        -- fix is thx to http://simononsoftware.com/postgresql-found-problem/
        -- IF rowsfound > 0 THEN
        --    raise notice 'Update!';
        --    RETURN;
        -- END IF;
        -- -- -- not there, so try to insert the key
        -- EXECUTE selStr;
        -- raise notice 'Insert!';
END;
$$
LANGUAGE plpgsql;

-- <2014-06-30 Mon 16:34> Creating a row that doesn't exist currently. Change date if used in future.
-- select upsertquoterow('AUD', 20140915, '2014-06-27 14:00:00', 0.9374, 0.9375, 0.9374, 0.9375, 2);
-- select upsertquoterow('AUD', 20140915, '2014-06-27 14:00:00', 0.9374, 0.9375, 0.9374, 0.9375, 2);
-- delete from aud where datetime = '2014-06-27 14:00:00';
-- select * from aud where datetime = '2014-06-27 14:00:00';


-- select upsertquoterow1('ZB');


-- select upsertquoterow('ZB', 20140919 , '2014-06-27 13:59:00.000000 -07:00:00', 136.84375, 136.875,
-- 136.8125, 136.8125, 97);
